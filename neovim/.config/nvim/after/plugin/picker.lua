local map = vim.keymap.set

-- File pickers
map("n", "<C-p>", function()
  Snacks.picker.files { hidden = true }
end, { desc = "Find files" })
map("n", "<C-g>", function()
  Snacks.picker.grep { hidden = true }
end, { desc = "Live grep" })
map("n", "gb", function()
  Snacks.picker.buffers { current = false, sort_lastused = true }
end, { desc = "Find in buffers" })

-- Git pickers
map("n", "<leader>gb", function()
  Snacks.picker.git_branches()
end, { desc = "Find branches" })
map("n", "<leader>gc", function()
  Snacks.picker.git_log()
end, { desc = "Find commits" })
map("n", "<leader>gd", function()
  Snacks.picker.git_log_file()
end, { desc = "Find commits in current file" })
map("n", "<leader>gs", function()
  Snacks.picker.git_status()
end, { desc = "Find in staged files" })
map("n", "<leader>gu", function()
  Snacks.picker.undo()
end, { desc = "Show undo list" })
