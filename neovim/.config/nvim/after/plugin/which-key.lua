local exists, wk = pcall(require, "which-key")

if not exists then
  return
end

wk.setup {
  enable = true,
  layout = {
    height = { min = 4, max = 15 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
}

local dashboard_config = {
  name = "Dashboard",
  f = { "<cmd>DashboardFindFile<cr>", "Find File" },
  h = { "<cmd>DashboardFindHistory<cr>", "Find History" },
  j = { "<cmd>DashboardJumpMark<cr>", "Jump Mark" },
  l = { "<cmd>SessionLoad<cr>", "Load Session" },
  n = { "<cmd>DashboardNewFile<cr>", "New File" },
  s = { "<cmd>SessionSave<cr>", "Save Session" },
  w = { "<cmd>DashboardFindWord<cr>", "Find Word" },
}

local files_config = {
  name = "Files",
  b = { "<cmd>Telescope buffers<cr>", "Find Buffer" },
  f = { "<cmd>Telescope find_files<cr>", "Find File" },
  g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
  h = { "<cmd>Telescope help_tags<cr>", "Help Tags" },
  r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
  t = { "<cmd>Telescope file_browser<cr>", "Workspace Tree View" },
}

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

wk.register({
  d = dashboard_config,
  f = files_config,
  g = git_config,
  v = vim_config,
}, { prefix = "<leader>" })

wk.register(dashboard_config, { prefix = "<leader>d" })
wk.register(files_config, { prefix = "<leader>f" })
wk.register(git_config, { prefix = "<leader>g" })
wk.register(vim_config, { prefix = "<leader>v" })
