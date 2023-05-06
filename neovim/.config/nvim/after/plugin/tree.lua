local exists, tree = pcall(require, "nvim-tree")

if not exists then
  return
end

tree.setup {
  disable_netrw = false,
  diagnostics = {
    enable = true,
  },
  update_focused_file = {
    enable = true,
  },
  git = {
    enable = false,
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
  vim.cmd "NvimTreeOpen"
  -- if vim.api.nvim_buf_get_name(0) == "" then
  --   vim.cmd "NvimTreeOpen"
  -- else
  --   vim.cmd "NvimTreeFindFile"
  -- end
end, { silent = true, desc = "Open tree sidebar" })