local exists, module = pcall(require, "lualine")

if not exists then
  return
end

local gps = require "nvim-gps"
local colors = require("custom.theme").colors

local filename = { "filename", file_status = true, path = 1, shorting_target = 80 }
local treesitter = { gps.get_location, cond = gps.is_available }
local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = {
    error = " ",
    warn = " ",
    info = " ",
    hint = " ",
  },
}
local diff = {
  "diff",
  diff_color = {
    added = {
      fg = colors.green,
    },
    modified = {
      fg = colors.blue,
    },
    removed = {
      fg = colors.red,
    },
  },
}

module.setup {
  options = {
    icons_enabled = true,
    theme = "onedark",
    component_separators = "",
    section_separators = "",
    disabled_filetypes = {},
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { filename, diff, diagnostics },
    lualine_c = { "branch", treesitter, "lsp_progress" },
    lualine_x = { "encoding" },
    lualine_y = { "fileformat", "filetype" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { filename },
    lualine_x = { "encoding", "fileformat", "filetype", "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = { "quickfix", "fugitive", "nvim-tree" },
}
