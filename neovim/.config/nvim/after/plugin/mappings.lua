local map = vim.keymap.set

map("n", "<leader>gg", "<cmd>Git<cr>", { desc = "Show git status" })
map("n", "<leader>gl", "<cmd>Git log<cr>", { desc = "Show git log" })
map("n", "<leader>gpp", "<cmd>Git push<cr>", { desc = "Push to remote" })
map("n", "<leader>gpf", "<cmd>Git push --force<cr>", { desc = "Push force to remote" })

-- Diffview
map("n", "<leader>gD", "<cmd>DiffviewOpen<cr>", { desc = "Open diff view" })
map("n", "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", { desc = "File history" })
map("n", "<leader>gH", "<cmd>DiffviewFileHistory<cr>", { desc = "Branch history" })
map("n", "<leader>gq", "<cmd>DiffviewClose<cr>", { desc = "Close diff view" })
