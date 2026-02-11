local exists, hlslens = pcall(require, "hlslens")

if not exists then
  return
end

hlslens.setup {
  calm_down = true,
  nearest_only = true,
}

local map = vim.keymap.set

local function search_err(err)
  local msg = err:match "Vim%(.-%):(.+)" or err
  vim.api.nvim_echo({ { msg, "ErrorMsg" } }, false, {})
end

map("n", "n", function()
  local ok, err = pcall(vim.cmd, "normal! " .. vim.v.count1 .. "n")
  if not ok then
    search_err(err)
    return
  end
  hlslens.start()
  vim.cmd "normal! zzzv"
end, { desc = "Next search result" })

map("n", "N", function()
  local ok, err = pcall(vim.cmd, "normal! " .. vim.v.count1 .. "N")
  if not ok then
    search_err(err)
    return
  end
  hlslens.start()
  vim.cmd "normal! zzzv"
end, { desc = "Previous search result" })

map("n", "*", function()
  local ok, err = pcall(vim.cmd, "normal! *")
  if not ok then
    search_err(err)
    return
  end
  hlslens.start()
  vim.cmd "normal! zzzv"
end, { desc = "Search word under cursor forward" })

map("n", "#", function()
  local ok, err = pcall(vim.cmd, "normal! #")
  if not ok then
    search_err(err)
    return
  end
  hlslens.start()
  vim.cmd "normal! zzzv"
end, { desc = "Search word under cursor backward" })

map("n", "g*", function()
  local ok, err = pcall(vim.cmd, "normal! g*")
  if not ok then
    search_err(err)
    return
  end
  hlslens.start()
  vim.cmd "normal! zzzv"
end, { desc = "Search word forward (partial)" })

map("n", "g#", function()
  local ok, err = pcall(vim.cmd, "normal! g#")
  if not ok then
    search_err(err)
    return
  end
  hlslens.start()
  vim.cmd "normal! zzzv"
end, { desc = "Search word backward (partial)" })

-- Setup hlslens for scrollbar
local scrollbar_exists, scrollbar_search = pcall(require, "scrollbar.handlers.search")

if scrollbar_exists then
  scrollbar_search.setup()
end
