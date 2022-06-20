local exists, module = pcall(require, "trouble")

if not exists then
  return
end

module.setup {
  use_diagnostic_signs = true,
}

vim.keymap.set("n", "<leader>xx", "<cmd>Trouble<cr>", { silent = true })
vim.keymap.set("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", { silent = true })
vim.keymap.set("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", { silent = true })
vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist<cr>", { silent = true })
vim.keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", { silent = true })
