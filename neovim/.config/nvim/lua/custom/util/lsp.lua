local async = require "plenary.async"
local misc = require "custom.util.misc"
local diagnostic = require "custom.util.diagnostic"
local M = {}

-- Floating preview close events
-- Ref: https://github.com/neovim/neovim/blob/master/runtime/lua/vim/lsp/util.lua#L1409
M.close_events = {
  "CursorMoved",
  "BufHidden",
  "InsertEnter",
  "InsertLeave",
  "WinScrolled",
}

-- Check if request is supported
function M.buf_request_supported(method)
  local method_supported = false

  for _, client in pairs(vim.lsp.get_clients { bufnr = 0 }) do
    if client:supports_method(method) then
      method_supported = true
    end
  end

  return method_supported
end

-- Get results from LSP request
function M.get_results(method)
  local flattened_results = {}

  if M.buf_request_supported(method) then
    local params = vim.lsp.util.make_position_params(0, "utf-8")
    local result = async.lsp.buf_request_all(0, method, params)

    for _, server_results in pairs(result) do
      if server_results.result then
        -- textDocument/definition can return Location or Location[]
        if vim.islist(server_results.result) then
          vim.list_extend(flattened_results, server_results.result)
          -- textDocument/hover can return { result = { contents[] }}
        elseif server_results.result.contents then
          if vim.islist(server_results.result.contents) then
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

local function show_line_diagnostics()
  -- Abort when virtual lines are active (they show details inline)
  if vim.diagnostic.config().virtual_lines then
    return
  end

  local mode = misc.get_mode()

  if mode ~= "n" then
    return
  end

  local any_floating_windows = misc.check_floating_windows()

  -- Abort when there is some floating window
  if any_floating_windows then
    return
  end

  local line_diagnostics = diagnostic.get_line_diagnostics()

  -- Show diagnostics when there are at least one in current line
  if #line_diagnostics ~= 0 then
    return vim.diagnostic.open_float(nil, {
      scope = "line",
      focusable = true,
      source = true,
      format = diagnostic.format_message,
      close_events = M.close_events,
    })
  end
end

local currentSignature = nil

local function show_signature_help()
  local mode = misc.get_mode()

  -- Show signature help first when in insert mode
  if mode ~= "i" then
    return
  end

  local results = M.get_results "textDocument/signatureHelp"

  -- Show signature help when available
  if #results ~= 0 then
    local signature = ""

    if not vim.tbl_isempty(results[1].signatures) then
      if results[1].activeParameter ~= nil then
        signature = signature .. results[1].activeParameter
      end

      if results[1].activeSignature ~= nil then
        signature = signature .. results[1].signatures[results[1].activeSignature + 1].label
      else
        signature = signature .. results[1].signatures[1].label
      end
    end

    if signature ~= currentSignature then
      currentSignature = signature

      misc.close_floating_windows()

      vim.lsp.buf.signature_help()
    end
  else
    currentSignature = nil

    misc.close_floating_windows()
  end
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

local function goto_definition()
  local results = M.get_results "textDocument/definition"

  -- Show definition when has some result
  if #results ~= 0 then
    return Snacks.picker.lsp_definitions()
  end

  local ft = vim.bo.filetype

  -- Show help when filetype is related to nvim
  if ft == "vim" or ft == "help" or ft == "lua" then
    return vim.api.nvim_command("help " .. vim.fn.expand "<cword>")
  end

  -- Show man by default
  vim.api.nvim_command(vim.o.keywordprg .. " " .. vim.fn.expand "<cword>")
end

--- Check if any attached server has a capability
--- @param capability string
--- @return boolean
local function has_server_with_capability(capability)
  local servers = vim.lsp.get_clients()
  local matching = vim.tbl_filter(function(server)
    return server.server_capabilities[capability]
  end, vim.tbl_values(servers))

  return not vim.tbl_isempty(matching)
end

-- Format
function M.format(opts)
  opts = opts or {}

  if not has_server_with_capability "documentFormattingProvider" then
    return
  end

  vim.lsp.buf.format(vim.tbl_deep_extend("force", {
    filter = function(client)
      local filetype = vim.bo.filetype

      if vim.tbl_contains({ "typescript", "javascript" }, filetype) then
        return client.name == "eslint"
      end

      return not vim.tbl_contains({ "jsonls" }, client.name)
    end,
  }, opts))
end

local ts_tools_ok, ts_tools_api = pcall(require, "typescript-tools.api")

--- @type fun(opts?: table)
M.add_missing_imports = ts_tools_ok and ts_tools_api.add_missing_imports or function() end
--- @type fun(opts?: table)
M.remove_unused = ts_tools_ok and ts_tools_api.remove_unused or function() end
M.show_line_diagnostics = async.void(show_line_diagnostics)
M.show_signature_help = async.void(show_signature_help)
M.document_highlight = async.void(document_highlight)
M.show_info = async.void(show_info)
M.goto_definition = async.void(goto_definition)

return M
