vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""
vim.g.copilot_filetypes = {
  TelescopePrompt = false,
}

vim.keymap.set("i", "‘", "<Plug>(copilot-next)", { noremap = false })
vim.keymap.set("i", "“", "<Plug>(copilot-previous)", { noremap = false })
vim.keymap.set("i", "«", "<Plug>(copilot-suggest)", { noremap = false })
vim.keymap.set("n", "<leader>cp", "<cmd>Copilot panel<cr>", { noremap = false })
