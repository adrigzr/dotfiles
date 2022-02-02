local exists, module = pcall(require, "onedark")

if not exists then
  return
end

module.setup {
  style = "dark",
  toggle_style_key = "<nop>",
  code_style = {
    comments = "italic",
    keywords = "none",
    functions = "none",
    strings = "none",
    variables = "none",
  },
}

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

  -- [LSP]
  vim.cmd("highlight LspSignatureActiveParameter gui=bold guifg=" .. colors.blue)
  vim.cmd("highlight DiagnosticUnnecessaryTag guifg=" .. colors.grey)
  vim.cmd("highlight LightBulbVirtualText guifg=" .. colors.blue)

  -- [Yank] Change yank highlight
  vim.cmd("highlight Yank guifg=" .. colors.bg0 .. " guibg=" .. colors.cyan)

  -- [TSContext]
  vim.cmd("highlight TreesitterContext guibg=" .. colors.bg1)

  -- [Ultest]
  vim.cmd("highlight UltestPass guifg=" .. colors.green)
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
