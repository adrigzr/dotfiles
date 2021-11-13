local exists, module = pcall(require, 'onedark')

if not exists then
  return
end

vim.g.onedark_style = 'dark'
vim.g.onedark_terminal_italics = 1
vim.g.onedark_toggle_style_keymap = '<nop>'

module.setup {}

vim.cmd[[
  highlight NvimTreeNormal guibg=none
  highlight NvimTreeEndOfBuffer guibg=none
  highlight NvimTreeVertSplit guibg=none
  highlight ExtraWhitespace guibg=#e86671
]]

require('lightspeed').init_highlight(true)
