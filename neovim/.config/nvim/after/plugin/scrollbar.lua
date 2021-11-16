local exists = pcall(require, "scrollbar")

if not exists then
  return
end

vim.g.scrollbar_winblend = 100
vim.g.scrollbar_excluded_filetypes = { "NvimTree" }
vim.g.scrollbar_highlight = {
  head = "Scrollbar",
  body = "Scrollbar",
  tail = "Scrollbar",
}
vim.g.scrollbar_shape = {
  head = "▎",
  body = "▎",
  tail = "▎",
}

vim.cmd [[
  augroup scrollbar
    autocmd!
    autocmd TabEnter,WinEnter,BufEnter,WinScrolled,VimResized * lua require('scrollbar').show()
    autocmd QuitPre,TabLeave,WinLeave,BufLeave                * lua require('scrollbar').clear()
  augroup END
]]
