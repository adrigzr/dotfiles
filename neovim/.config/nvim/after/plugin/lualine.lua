local exists, module = pcall(require, "lualine")

if not exists then
  return
end

local gps = require('nvim-gps')

local filename = { 'filename', file_status = true, path = 1 }
local treesitter = { gps.get_location, cond = gps.is_available }
local diagnostics = { 'diagnostics', sources= { 'nvim_lsp' } }

module.setup {
  options = {
    icons_enabled = true,
    theme = 'onedark',
    component_separators = '',
    section_separators = '',
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', diagnostics },
    lualine_c = { filename, treesitter },
    lualine_x = { 'encoding' },
    lualine_y = { 'fileformat', 'filetype'},
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { filename },
    lualine_x = { 'encoding' },
    lualine_y = { 'fileformat', 'filetype'},
    lualine_z = { 'location' }
  },
  tabline = {},
  extensions = { 'quickfix', 'fugitive', 'nvim-tree' }
}
