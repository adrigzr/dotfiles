local exists, module = pcall(require, "trouble")

if not exists then
  return
end

module.setup {
  use_diagnostic_signs = true,
}

require("which-key").register({
  name = "Trouble",
  x = { "<cmd>Trouble<cr>", "Open trouble" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Open workspace diagnostics" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Open document diagnostics" },
  l = { "<cmd>Trouble loclist<cr>", "Open location list" },
  q = { "<cmd>Trouble quickfix<cr>", "Open quickfix list" },
}, { prefix = "<leader>x" })
