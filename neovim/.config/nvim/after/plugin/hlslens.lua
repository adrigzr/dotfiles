local exists, hlslens = pcall(require, "hlslens")

if not exists then
  return
end

hlslens.setup {
  calm_down = true,
  nearest_only = true,
}

local map = vim.keymap.set

map("n", "n", function()
  vim.cmd("normal! " .. vim.v.count1 .. "n")
  hlslens.start()
  vim.cmd "normal! zzzv"
end, { desc = "Next search result" })

map("n", "N", function()
  vim.cmd("normal! " .. vim.v.count1 .. "N")
  hlslens.start()
  vim.cmd "normal! zzzv"
end, { desc = "Previous search result" })

map("n", "*", function()
  vim.cmd "normal! *"
  hlslens.start()
  vim.cmd "normal! zzzv"
end, { desc = "Search word under cursor forward" })

map("n", "#", function()
  vim.cmd "normal! #"
  hlslens.start()
  vim.cmd "normal! zzzv"
end, { desc = "Search word under cursor backward" })

map("n", "g*", function()
  vim.cmd "normal! g*"
  hlslens.start()
  vim.cmd "normal! zzzv"
end, { desc = "Search word forward (partial)" })

map("n", "g#", function()
  vim.cmd "normal! g#"
  hlslens.start()
  vim.cmd "normal! zzzv"
end, { desc = "Search word backward (partial)" })

-- Setup hlslens for scrollbar
local scrollbar_exists, scrollbar_search = pcall(require, "scrollbar.handlers.search")

if scrollbar_exists then
  scrollbar_search.setup()
end
