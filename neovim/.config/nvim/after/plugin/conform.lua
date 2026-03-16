local exists, conform = pcall(require, "conform")

if not exists then
  return
end

-- Disable formatting for YAML files with Go template syntax (e.g. Authelia, Helm)
-- prettier/prettierd cannot handle {{ .Variable }} delimiters and breaks them on save
vim.api.nvim_create_autocmd("FileType", {
  pattern = "yaml",
  callback = function(ev)
    local lines = vim.api.nvim_buf_get_lines(ev.buf, 0, 500, false)

    for _, line in ipairs(lines) do
      if line:find("{{", 1, true) then
        vim.b[ev.buf].disable_autoformat = true
        return
      end
    end
  end,
})

conform.setup {
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "prettierd", "prettier", stop_after_first = true },
    javascriptreact = { "prettierd", "prettier", stop_after_first = true },
    typescript = { "prettierd", "prettier", stop_after_first = true },
    typescriptreact = { "prettierd", "prettier", stop_after_first = true },
    json = { "prettierd", "prettier", stop_after_first = true },
    jsonc = { "prettierd", "prettier", stop_after_first = true },
    html = { "prettierd", "prettier", stop_after_first = true },
    css = { "prettierd", "prettier", stop_after_first = true },
    scss = { "prettierd", "prettier", stop_after_first = true },
    markdown = { "prettierd", "prettier", stop_after_first = true },
    yaml = { "prettierd", "prettier", stop_after_first = true },
    graphql = { "prettierd", "prettier", stop_after_first = true },
    python = { "black" },
    ruby = { "rubocop" },
    rust = { "rustfmt" },
    sh = { "shfmt" },
    bash = { "shfmt" },
  },
}
