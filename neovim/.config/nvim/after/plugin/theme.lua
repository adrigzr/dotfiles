local exists = pcall(require, "onedark")

if not exists then
  return
end

vim.g.onedark_style = "dark"
vim.g.onedark_terminal_italics = 1
vim.g.onedark_toggle_style_keymap = "<nop>"

vim.cmd [[
  colorscheme onedark

  " [Tree] Turn tree background same as regular background
  highlight NvimTreeNormal guibg=none
  highlight NvimTreeEndOfBuffer guibg=none
  highlight NvimTreeVertSplit guibg=none

  " [Better Whitespace] Turn extra whitespace red match the theme
  highlight ExtraWhitespace guibg=#e86671

  " [LSP] Underline active parameter in signature help
  highlight LspSignatureActiveParameter gui=undercurl

  " [Native] Change float preview window border to match background
  highlight def link FloatBorder NormalFloat

  " [Scrollbar] Change scrollback
  highlight def link Scrollbar Delimiter
]]

-- [Rainbow] Change treesitter rainbow colors
for i = 1, 7 do
  vim.cmd("highlight rainbowcol" .. i .. " guifg=" .. vim.g["terminal_color_" .. i])
end

-- Init lightspeed colors
require("lightspeed").init_highlight(true)
