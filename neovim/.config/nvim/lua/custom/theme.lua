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

    " [InlayHints]
    highlight! def link LspInlayHint Comment
  ]]

  -- [Rainbow] Change treesitter rainbow colors
  for i = 1, 7 do
    vim.cmd("highlight rainbowcol" .. i .. " guifg=" .. vim.g["terminal_color_" .. i])
  end

  -- [GitSigns] Change blame line signs
  vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { italic = true, fg = colors.grey })

  -- [Theme] Change cursor line
  vim.api.nvim_set_hl(0, "CursorLineNr", { bg = colors.bg1 })

  -- [LSP]
  vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { bold = true, fg = colors.blue })
  vim.api.nvim_set_hl(0, "DiagnosticUnnecessaryTag", { fg = colors.grey })
  vim.api.nvim_set_hl(0, "LightBulbVirtualText", { fg = colors.blue })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { italic = true, fg = colors.red })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { italic = true, fg = colors.yellow })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { italic = true, fg = colors.cyan })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { italic = true, fg = colors.purple })

  -- [Yank] Change yank highlight
  vim.api.nvim_set_hl(0, "Yank", { fg = colors.bg0, bg = colors.cyan })

  -- [TSContext]
  vim.api.nvim_set_hl(0, "TreesitterContext", { bg = colors.bg1 })

  -- [Neotest]
  vim.api.nvim_set_hl(0, "NeotestPassed", { fg = colors.green })
  vim.api.nvim_set_hl(0, "NeotestRunning", { fg = colors.cyan })
  vim.api.nvim_set_hl(0, "NeotestSkipped", { fg = colors.yellow })
  vim.api.nvim_set_hl(0, "NeotestFailed", { fg = colors.red })

  -- [Coverage]
  -- require("coverage.highlight").setup()

  -- [Ufo]
  vim.api.nvim_set_hl(0, "Folded", { bg = util.darken(colors.dark_cyan, 0.25, colors.bg0) })
  vim.api.nvim_set_hl(0, "FoldColumn", { fg = colors.grey })
  vim.api.nvim_set_hl(0, "UfoFoldedFg", { fg = colors.green })

  -- [Hydra]
  vim.api.nvim_set_hl(0, "HydraRed", { fg = colors.red })
  vim.api.nvim_set_hl(0, "HydraBlue", { fg = colors.blue })
  vim.api.nvim_set_hl(0, "HydraAmaranth", { fg = colors.cyan })
  vim.api.nvim_set_hl(0, "HydraTeal", { fg = colors.green })
  vim.api.nvim_set_hl(0, "HydraPink", { fg = colors.orange })

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
      vim.api.nvim_set_hl(0, "Notify" .. level:upper() .. part, { fg = color })
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
