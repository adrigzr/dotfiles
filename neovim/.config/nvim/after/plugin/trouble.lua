local exists, trouble = pcall(require, "trouble")

if not exists then
  return
end

local map = vim.keymap.set

trouble.setup {
  auto_close = true,
}

map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Open trouble" })
map("n", "<leader>xw", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Open workspace diagnostics" })
map("n", "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Open document diagnostics" })
map("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>", { desc = "Open location list" })
map("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", { desc = "Open quickfix list" })
map("n", "<leader>xr", "<cmd>Trouble lsp_references toggle<cr>", { desc = "Open lsp references" })
map("n", "<leader>xe", "<cmd>Trouble lsp_definitions toggle<cr>", { desc = "Open lsp definitions" })
map("n", "<leader>xt", "<cmd>Trouble lsp_type_definitions toggle<cr>", { desc = "Open lsp type definitions" })
map("n", "<leader>xj", function()
  trouble.next { skip_groups = true, jump = true }
end, { desc = "Jump to next item" })
map("n", "<leader>xk", function()
  trouble.prev { skip_groups = true, jump = true }
end, { desc = "Jump to previous item" })
