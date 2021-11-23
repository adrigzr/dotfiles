-- Defined before require
vim.g.nvim_tree_gitignore = 1
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_disable_window_picker = 1
vim.g.nvim_tree_show_icons = {
  git = 0,
  folders = 1,
  files = 1,
  folder_arrows = 1,
}

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
}

-- Mappings
vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>NvimTreeFindFile<CR>", { noremap = true, silent = true })

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
