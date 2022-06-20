local exists, wk = pcall(require, "which-key")

if not exists then
  return
end

local git_config = {
  name = "Git",
  b = { "<cmd>Telescope git_branches<cr>", "Branches" },
  c = { "<cmd>Telescope git_commits<cr>", "Commits" },
  d = { "<cmd>Telescope git_bcommits<cr>", "Buffer Commits" },
  s = { "<cmd>Telescope git_status<cr>", "Status" },
}

local vim_config = {
  name = "Vim",
  i = { "<cmd>LspInstall<cr>", "Install LSP" },
  u = { "<cmd>LspUninstall<cr>", "Uninstall LSP" },
}

wk.setup {
  enable = true,
  layout = {
    height = { min = 4, max = 15 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
}

wk.register({
  g = git_config,
  v = vim_config,
}, { prefix = "<leader>" })

wk.register(git_config, { prefix = "<leader>g" })
wk.register(vim_config, { prefix = "<leader>v" })
