local exists, module = pcall(require, "nvim-tree")

if not exists then
  return
end

module.setup {
  disable_netrw = false,
  diagnostics = {
    enable = true,
  },
  update_focused_file = {
    enable = true,
  },
  git = {
    ignore = true,
  },
  actions = {
    open_file = {
      resize_window = false,
      window_picker = {
        enable = false,
      },
    },
  },
  renderer = {
    highlight_git = true,
    indent_markers = {
      enable = true,
    },
    icons = {
      show = {
        git = false,
        file = true,
        folder = true,
        folder_arrow = true,
      },
    },
  },
}

-- Mappings
vim.keymap.set("n", "<leader>t", function()
  if vim.api.nvim_buf_get_name(0) == "" then
    module.open()
  else
    module.find_file(true)
  end
end, { silent = true })

-- Custom colors
vim.cmd [[
  augroup tree_theme
  autocmd!
  autocmd ColorScheme * highlight NvimTreeNormal guibg=none
  autocmd ColorScheme * highlight NvimTreeEndOfBuffer guibg=none
  autocmd ColorScheme * highlight NvimTreeVertSplit guibg=none
  autocmd ColorScheme * highlight def link NvimTreeLspDiagnosticsError DiagnosticSignError
  autocmd ColorScheme * highlight def link NvimTreeLspDiagnosticsWarning DiagnosticSignWarn
  autocmd ColorScheme * highlight def link NvimTreeLspDiagnosticsInformation DiagnosticSignInfo
  autocmd ColorScheme * highlight def link NvimTreeLspDiagnosticsHint DiagnosticSignHint
  augroup END
]]
