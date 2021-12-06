local exists, module = pcall(require, "onedark")

if not exists then
  return
end

vim.g.onedark_style = "dark"
vim.g.onedark_terminal_italics = 1
vim.g.onedark_toggle_style_keymap = "<nop>"

module.setup {}

local colors = require "onedark.colors"

local function setup()
  vim.cmd [[
    colorscheme onedark

    " [Native] Change float preview window border to match background
    highlight def link FloatBorder TelescopeResultsBorder
    highlight def link NormalFloat Normal

    " [Native] Change match paren
    highlight MatchParen gui=underline guifg=none guibg=none
  ]]

  -- [Native] Folds
  vim.cmd("highlight Folded gui=none guifg=none guibg=" .. colors.dark_cyan)

  -- [Rainbow] Change treesitter rainbow colors
  for i = 1, 7 do
    vim.cmd("highlight rainbowcol" .. i .. " guifg=" .. vim.g["terminal_color_" .. i])
  end

  -- [GitSigns] Change blame line signs
  vim.cmd("highlight GitSignsCurrentLineBlame gui=italic guifg=" .. colors.grey)

  -- [Theme] Change cursor line
  vim.cmd("highlight CursorLineNr guibg=" .. colors.bg1)
end

vim.cmd [[
  augroup custom_theme
  autocmd!
  autocmd VimEnter * ++nested lua require "custom.theme".setup()
  augroup END
]]

return {
  colors = colors,
  setup = setup,
}
