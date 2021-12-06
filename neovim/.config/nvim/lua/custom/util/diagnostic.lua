local M = {}

-- Get current line diagnostics.
function M.get_line_diagnostics()
  local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
  local bufnr = vim.api.nvim_get_current_buf()

  return vim.diagnostic.get(bufnr, { lnum = lnum })
end

-- Format diagnostic messasge
function M.format_message(diagnostic)
  if diagnostic.user_data then
    return string.format("%s (%s)", diagnostic.message, diagnostic.user_data.lsp.code)
  end

  return string.format("%s", diagnostic.message)
end

-- Strikethrough deprecated diagnostics
M.strikethrough_handler = {
  show = function(namespace, bufnr, diagnostics, _)
    local ns = vim.diagnostic.get_namespace(namespace)

    if not ns.user_data.strikethrough_ns then
      ns.user_data.strikethrough_ns = vim.api.nvim_create_namespace ""
    end

    local higroup = "DiagnosticStrikethroughDeprecated"
    local strikethrough_ns = ns.user_data.strikethrough_ns

    for _, diagnostic in ipairs(diagnostics) do
      local user_data = diagnostic.user_data

      if user_data and user_data.lsp.tags and vim.tbl_contains(user_data.lsp.tags, 2) then
        vim.highlight.range(
          bufnr,
          strikethrough_ns,
          higroup,
          { diagnostic.lnum, diagnostic.col },
          { diagnostic.end_lnum, diagnostic.end_col }
        )
      end
    end
  end,
  hide = function(namespace, bufnr)
    local ns = vim.diagnostic.get_namespace(namespace)

    if ns.user_data.strikethrough_ns then
      vim.api.nvim_buf_clear_namespace(bufnr, ns.user_data.strikethrough_ns, 0, -1)
    end
  end,
}

return M
