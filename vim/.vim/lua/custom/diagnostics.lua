M = {}

-- Format diagnostic messasge
function M.format_message(diagnostic)
  return string.format("%s (%s)", diagnostic.message, diagnostic.user_data.lsp.code)
end

-- Border style
M.border = {
  {"╭", "NormalFloat"},
  {"─", "NormalFloat"},
  {"╮", "NormalFloat"},
  {"│", "NormalFloat"},
  {"╯", "NormalFloat"},
  {"─", "NormalFloat"},
  {"╰", "NormalFloat"},
  {"│", "NormalFloat"},
}

-- Floating preview close events
-- Ref: https://github.com/neovim/neovim/blob/master/runtime/lua/vim/lsp/util.lua#L1409
M.close_events = {
  -- Defaults
  "CursorMoved",
  -- "CursorMovedI",
  "BufHidden",
  -- "InsertCharPre",
  -- Custom
  "InsertEnter",
  "BufEnter",
  "BufLeave",
  "TextChangedI",
  "WinScrolled",
}

local function get_line_diagnostics()
  local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
  local bufnr = vim.api.nvim_get_current_buf()

  return vim.diagnostic.get(bufnr, { lnum = lnum })
end

local function get_floating_windows()
  local list_wins = vim.api.nvim_list_wins()
  local current_win = vim.api.nvim_get_current_win()

  return vim.tbl_filter(function(v)
    local config = vim.api.nvim_win_get_config(v)

    return config.relative =="win" and config.win == current_win
  end, list_wins)
end

local function get_mode()
  local tbl = vim.api.nvim_get_mode()

  return tbl.mode
end

local function get_results(action)
  local flattened_results = {}
  local params = vim.lsp.util.make_position_params()
  local result, err = vim.lsp.buf_request_sync(0, action, params, 10000)

  if not err then
    for _, server_results in pairs(result) do
      if server_results.result then
        -- textDocument/definition can return Location or Location[]
        if not vim.tbl_islist(server_results.result) then
          flattened_results = { server_results.result }
          break
        end

        vim.list_extend(flattened_results, server_results.result)
      end
    end
  end

  return flattened_results
end

-- Hover handler
function M.hover()
  -- Abort when lsp is not ready or completion is visible
  if not vim.lsp.buf.server_ready() or require('cmp').visible() then
    return
  end

  local floating_windows = get_floating_windows()

  -- Abort when there is some floating window
  if #floating_windows ~= 0 then
    return
  end

  local mode = get_mode()

  -- Only show diagnostics when in normal mode
  if mode == "n" then
    local line_diagnostics = get_line_diagnostics()

    -- Show diagnostics when there are at least one in current line
    if #line_diagnostics ~= 0 then
      return vim.diagnostic.show_line_diagnostics({
        border = M.border,
        focusable = false,
        source = 'always',
        format = M.format_message,
        close_events = M.close_events,
      })
    end
  end

  -- Only show signature help when in insert mode
  if mode == "i" then
    local results = get_results("textDocument/signatureHelp")

    -- Show signature help when available
    if #results ~= 0 then
      return vim.lsp.buf.signature_help()
    end
  end

  local results = get_results("textDocument/hover")

  -- Show lsp hover when available
  if #results ~= 0 then
    return vim.lsp.buf.hover()
  end
end

-- Goto definition handler
function M.goto_definition()
  local results = get_results("textDocument/definition")

  -- Show definition when has some result
  if #results ~= 0 then
    return vim.api.nvim_command("Telescope lsp_definitions")
  end

  local ft = vim.bo.filetype

  -- Show help when filetype is related to nvim
  if ft == "vim" or ft == "help" or ft == "lua" then
    return vim.api.nvim_command("help " .. vim.fn.expand("<cword>"))
  end

  -- Show man by default
  vim.api.nvim_command(
    vim.o.keywordprg .. " " .. vim.fn.expand("<cword>")
  )
end

-- Check if prev character is a space
function M.check_backspace()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    return true
  else
    return false
  end
end

return M
