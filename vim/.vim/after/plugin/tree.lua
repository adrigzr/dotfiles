-- Defined before require
vim.g.nvim_tree_gitignore = 1
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_disable_window_picker = 1

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

-- Reset tree background color
vim.cmd[[
  highlight NvimTreeNormal guibg=none
  highlight NvimTreeEndOfBuffer guibg=none
]]
