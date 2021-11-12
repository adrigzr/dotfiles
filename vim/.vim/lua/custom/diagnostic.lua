local M = {}

-- Get current line diagnostics.
function M.get_line_diagnostics()
  local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
  local bufnr = vim.api.nvim_get_current_buf()

  return vim.diagnostic.get(bufnr, { lnum = lnum })
end

-- Format diagnostic messasge
function M.format_message(diagnostic)
  return string.format("%s (%s)", diagnostic.message, diagnostic.user_data.lsp.code)
end

return M
