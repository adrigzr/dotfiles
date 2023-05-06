local exists, trouble = pcall(require, "trouble")

if not exists then
  return
end

local bind = require("custom.util.misc").bind
local map = vim.keymap.set

trouble.setup {
  use_diagnostic_signs = true,
  auto_open = false,
  auto_close = true,
}

map("n", "<leader>xx", "<cmd>Trouble<cr>", { desc = "Open trouble" })
map("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", { desc = "Open workspace diagnostics" })
map("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", { desc = "Open document diagnostics" })
map("n", "<leader>xl", "<cmd>Trouble loclist<cr>", { desc = "Open location list" })
map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", { desc = "Open quickfix list" })
map("n", "<leader>xr", "<cmd>Trouble lsp_references<cr>", { desc = "Open lsp references" })
map("n", "<leader>xe", "<cmd>Trouble lsp_definitions<cr>", { desc = "Open lsp definitions" })
map("n", "<leader>xt", "<cmd>Trouble lsp_type_definitions<cr>", { desc = "Open lsp type definitions" })
map("n", "<leader>xj", bind(trouble.next, { { skip_groups = true, jump = true } }), { desc = "Jump to next item" })
map(
  "n",
  "<leader>xk",
  bind(trouble.previous, { { skip_groups = true, jump = true } }),
  { desc = "Jump to previous item" }
)
