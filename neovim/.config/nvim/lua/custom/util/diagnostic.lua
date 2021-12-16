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
-- Fade out unnecessary diagnostics
M.lsp_tags_handler = {
  show = function(namespace, bufnr, diagnostics, _)
    local ns = vim.diagnostic.get_namespace(namespace)

    if not ns.user_data.lsp_tags_ns then
      ns.user_data.lsp_tags_ns = vim.api.nvim_create_namespace ""
    end

    local lsp_tags_ns = ns.user_data.lsp_tags_ns

    for _, diagnostic in ipairs(diagnostics) do
      local user_data = diagnostic.user_data

      if user_data and user_data.lsp.tags then
        if vim.tbl_contains(user_data.lsp.tags, 1) then
          vim.highlight.range(
            bufnr,
            lsp_tags_ns,
            "DiagnosticUnnecessaryTag",
            { diagnostic.lnum, diagnostic.col },
            { diagnostic.end_lnum, diagnostic.end_col }
          )
        end
        if vim.tbl_contains(user_data.lsp.tags, 2) then
          vim.highlight.range(
            bufnr,
            lsp_tags_ns,
            "DiagnosticDeprecatedTag",
            { diagnostic.lnum, diagnostic.col },
            { diagnostic.end_lnum, diagnostic.end_col }
          )
        end
      end
    end
  end,
  hide = function(namespace, bufnr)
    local ns = vim.diagnostic.get_namespace(namespace)

    if ns.user_data.lsp_tags_ns then
      vim.api.nvim_buf_clear_namespace(bufnr, ns.user_data.lsp_tags_ns, 0, -1)
    end
  end,
}

return M
