local map = vim.keymap.set

map("n", "<leader>gg", "<cmd>Git<cr>", { desc = "Show git status" })
map("n", "<leader>gl", "<cmd>Git log<cr>", { desc = "Show git log" })
map("n", "<leader>gpp", "<cmd>Git push<cr>", { desc = "Push to remote" })
map("n", "<leader>gpf", "<cmd>Git push --force<cr>", { desc = "Push force to remote" })
