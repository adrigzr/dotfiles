local exists, grug_far = pcall(require, "grug-far")

if not exists then
  return
end

grug_far.setup {}

local map = vim.keymap.set

-- Open grug-far
map("n", "<leader>ss", function()
  grug_far.open()
end, { desc = "Open search and replace" })

-- Search current word
map("n", "<leader>sw", function()
  grug_far.open { prefills = { search = vim.fn.expand "<cword>" } }
end, { desc = "Search current word" })

map("v", "<leader>s", function()
  grug_far.with_visual_selection()
end, { desc = "Search current selection" })

-- Search in current file
map("n", "<leader>sp", function()
  grug_far.open { prefills = { paths = vim.fn.expand "%" } }
end, { desc = "Search in current file" })
