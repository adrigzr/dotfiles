local async = require "plenary.async"
local misc = require "custom.util.misc"
local diagnostic = require "custom.util.diagnostic"
local M = {}

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

-- Check if request is supported
function M.buf_request_supported(method)
  local method_supported = false

  vim.lsp.for_each_buffer_client(0, function(client)
    if client.supports_method(method) then
      method_supported = true
    end
  end)

  return method_supported
end

-- Get results from LSP request
function M.get_results(method)
  local flattened_results = {}

  if M.buf_request_supported(method) then
    local params = vim.lsp.util.make_position_params()
    local result = async.lsp.buf_request_all(0, method, params)

    for _, server_results in pairs(result) do
      if server_results.result then
        -- textDocument/definition can return Location or Location[]
        if vim.tbl_islist(server_results.result) then
          vim.list_extend(flattened_results, server_results.result)
          -- textDocument/hover can return { result = { contents[] }}
        elseif server_results.result.contents then
          if vim.tbl_islist(server_results.result.contents) then
            vim.list_extend(flattened_results, server_results.result.contents)
          else
            flattened_results = { server_results.result.contents }
          end
        else
          flattened_results = { server_results.result }
        end
      end
    end
  end

  return flattened_results
end

local function document_highlight()
  local results = M.get_results "textDocument/documentHighlight"

  if #results ~= 0 then
    vim.lsp.buf.document_highlight()
  end
end

local function hover()
  -- Abort when lsp is not ready or completion is visible or copilot has suggestions
  if not vim.lsp.buf.server_ready() or require("cmp").visible() or vim.b._copilot_suggestion then
    return
  end

  local mode = misc.get_mode()

  -- Highlight current word when in normal mode
  if mode == "n" then
    document_highlight()
  end

  local any_floating_windows = misc.check_floating_windows()

  -- Abort when there is some floating window
  if any_floating_windows then
    return
  end

  -- Only show diagnostics when in normal mode
  if mode == "n" then
    local line_diagnostics = diagnostic.get_line_diagnostics()

    -- Show diagnostics when there are at least one in current line
    if #line_diagnostics ~= 0 then
      return vim.diagnostic.open_float(nil, {
        scope = "line",
        border = "rounded",
        focusable = false,
        source = "always",
        format = diagnostic.format_message,
        close_events = M.close_events,
      })
    end
  end

  local results

  -- Show signature help first when in insert mode
  if mode == "i" then
    results = M.get_results "textDocument/signatureHelp"

    -- Show signature help when available
    if #results ~= 0 then
      return vim.lsp.buf.signature_help()
    end
  end
end

-- Hover handler
function M.hover()
  async.run(hover)
end

-- Show hover or signature help
local function show_info()
  local results = M.get_results "textDocument/hover"

  -- Show lsp hover when available
  if #results ~= 0 then
    return vim.lsp.buf.hover()
  end

  -- Show signature help first when in insert mode
  results = M.get_results "textDocument/signatureHelp"

  -- Show signature help when available
  if #results ~= 0 then
    return vim.lsp.buf.signature_help()
  end
end

-- Show info handler
function M.show_info()
  async.run(show_info)
end

local function goto_definition()
  local results = M.get_results "textDocument/definition"

  -- Show definition when has some result
  if #results ~= 0 then
    return vim.api.nvim_command "Telescope lsp_definitions"
  end

  local ft = vim.bo.filetype

  -- Show help when filetype is related to nvim
  if ft == "vim" or ft == "help" or ft == "lua" then
    return vim.api.nvim_command("help " .. vim.fn.expand "<cword>")
  end

  -- Show man by default
  vim.api.nvim_command(vim.o.keywordprg .. " " .. vim.fn.expand "<cword>")
end

-- Goto definition handler
function M.goto_definition()
  async.run(goto_definition)
end

return M
