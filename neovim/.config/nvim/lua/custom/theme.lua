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
local util = require "onedark.util"

local function setup()
  vim.cmd [[
    colorscheme onedark

    " [Native] Change float preview window border to match background
    highlight! def link FloatBorder TelescopeResultsBorder
    highlight! def link NormalFloat Normal

    " [Native] WinBar
    highlight WinBarNC gui=none

    " [Native] Change match paren
    highlight MatchParen gui=underline guifg=none guibg=none

    " [Tree]
    highlight NvimTreeNormal guibg=none
    highlight NvimTreeEndOfBuffer guibg=none
    highlight NvimTreeVertSplit guibg=none
    highlight def link NvimTreeLspDiagnosticsError DiagnosticSignError
    highlight def link NvimTreeLspDiagnosticsWarning DiagnosticSignWarn
    highlight def link NvimTreeLspDiagnosticsInformation DiagnosticSignInfo
    highlight def link NvimTreeLspDiagnosticsHint DiagnosticSignHint
  ]]

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
  vim.cmd("highlight DiagnosticVirtualTextError gui=italic guifg=" .. colors.red .. " guibg=none")
  vim.cmd("highlight DiagnosticVirtualTextWarn gui=italic guifg=" .. colors.yellow .. " guibg=none")
  vim.cmd("highlight DiagnosticVirtualTextInfo gui=italic guifg=" .. colors.cyan .. " guibg=none")
  vim.cmd("highlight DiagnosticVirtualTextHint gui=italic guifg=" .. colors.purple .. " guibg=none")

  -- [Yank] Change yank highlight
  vim.cmd("highlight Yank guifg=" .. colors.bg0 .. " guibg=" .. colors.cyan)

  -- [TSContext]
  vim.cmd("highlight TreesitterContext guibg=" .. colors.bg1)

  -- [Neotest]
  vim.cmd("highlight NeotestPassed guifg=" .. colors.green)
  vim.cmd("highlight NeotestRunning guifg=" .. colors.cyan)
  vim.cmd("highlight NeotestSkipped guifg=" .. colors.yellow)
  vim.cmd("highlight NeotestFailed guifg=" .. colors.red)

  -- [Ufo]
  vim.cmd("highlight Folded gui=none guifg=none guibg=" .. util.darken(colors.dark_cyan, 0.25, colors.bg0))
  vim.cmd("highlight FoldColumn guifg=" .. colors.grey .. " guibg=none")
  vim.cmd("highlight UfoFoldedFg guifg=" .. colors.green)

  -- [Hydra]
  vim.cmd("highligh HydraRed guifg=" .. colors.red)
  vim.cmd("highligh HydraBlue guifg=" .. colors.blue)
  vim.cmd("highligh HydraAmaranth guifg=" .. colors.cyan)
  vim.cmd("highligh HydraTeal guifg=" .. colors.green)
  vim.cmd("highligh HydraPink guifg=" .. colors.orange)

  -- [Notify]
  local levels = {
    error = {
      Border = colors.dark_red,
      Icon = colors.red,
      Title = colors.red,
    },
    warn = {
      Border = colors.dark_yellow,
      Icon = colors.yellow,
      Title = colors.yellow,
    },
    info = {
      Border = colors.dark_cyan,
      Icon = colors.cyan,
      Title = colors.cyan,
    },
    debug = {
      Border = colors.dark_purple,
      Icon = colors.purple,
      Title = colors.purple,
    },
    trace = {
      Border = colors.dark_purple,
      Icon = colors.purple,
      Title = colors.purple,
    },
  }

  for level, parts in pairs(levels) do
    for part, color in pairs(parts) do
      vim.cmd("highlight Notify" .. level:upper() .. part .. " guifg=" .. color)
    end
  end
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
