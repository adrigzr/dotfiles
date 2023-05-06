local exists, module = pcall(require, "lualine")

if not exists then
  return
end

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
    lualine_b = { "branch", diagnostics },
    lualine_c = { "lsp_progress" },
    lualine_x = { "encoding" },
    lualine_y = { "fileformat", "filetype" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = { "encoding", "fileformat", "filetype", "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = { "quickfix", "fugitive", "nvim-tree", "nvim-dap-ui", "man" },
}
