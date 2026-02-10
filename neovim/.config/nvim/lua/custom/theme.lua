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
  vim.cmd.colorscheme "onedark"

  -- [Native] Change float preview window border to match background
  vim.api.nvim_set_hl(0, "FloatBorder", { link = "TelescopeResultsBorder" })
  vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })

  -- [Native] WinBar
  vim.api.nvim_set_hl(0, "WinBarNC", {})
  vim.api.nvim_set_hl(0, "WinBar", {})

  -- [Native] Change match paren
  vim.api.nvim_set_hl(0, "MatchParen", { underline = true })

  -- [Tree]
  vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "NvimTreeVertSplit", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "NvimTreeLspDiagnosticsError", { link = "DiagnosticSignError" })
  vim.api.nvim_set_hl(0, "NvimTreeLspDiagnosticsWarning", { link = "DiagnosticSignWarn" })
  vim.api.nvim_set_hl(0, "NvimTreeLspDiagnosticsInformation", { link = "DiagnosticSignInfo" })
  vim.api.nvim_set_hl(0, "NvimTreeLspDiagnosticsHint", { link = "DiagnosticSignHint" })

  -- [InlayHints]
  vim.api.nvim_set_hl(0, "LspInlayHint", { link = "Comment" })

  -- [Rainbow] Change rainbow-delimiters colors
  for i = 1, 7 do
    vim.api.nvim_set_hl(0, "RainbowDelimiter" .. i, { fg = vim.g["terminal_color_" .. i] })
  end

  -- [GitSigns] Change blame line signs
  vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { italic = true, fg = colors.grey })

  -- [Theme] Change cursor line
  vim.api.nvim_set_hl(0, "CursorLineNr", { bg = colors.bg1 })

  -- [LSP]
  vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { bold = true, fg = colors.blue })
  vim.api.nvim_set_hl(0, "DiagnosticUnnecessaryTag", { fg = colors.grey })
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

  -- [Ufo]
  vim.api.nvim_set_hl(0, "Folded", { bg = util.darken(colors.dark_cyan, 0.25, colors.bg0) })
  vim.api.nvim_set_hl(0, "FoldColumn", { fg = colors.grey })
  vim.api.nvim_set_hl(0, "UfoFoldedFg", { fg = colors.green })
end

local custom_theme_group = vim.api.nvim_create_augroup("custom_theme", {})

vim.api.nvim_create_autocmd("VimEnter", {
  group = custom_theme_group,
  nested = true,
  callback = function()
    require("custom.theme").setup()
  end,
})

return {
  colors = colors,
  setup = setup,
}
