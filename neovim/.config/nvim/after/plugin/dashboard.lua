local exists, dashboard = pcall(require, "dashboard")

if not exists then
  return
end

dashboard.setup {
  theme = "hyper",
  config = {
    header = {
      " █████╗ ██████╗ ██████╗ ██╗ ██████╗ ███████╗██████╗ ",
      "██╔══██╗██╔══██╗██╔══██╗██║██╔════╝ ╚══███╔╝██╔══██╗",
      "███████║██║  ██║██████╔╝██║██║  ███╗  ███╔╝ ██████╔╝",
      "██╔══██║██║  ██║██╔══██╗██║██║   ██║ ███╔╝  ██╔══██╗",
      "██║  ██║██████╔╝██║  ██║██║╚██████╔╝███████╗██║  ██║",
      "╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝",
      "",
      "",
    },
    shortcut = {
      {
        desc = " New file",
        action = "enew",
        shortcut = "<space>bt",
      },
      {
        desc = " Find file",
        action = "Telescope find_files",
        shortcut = "<ctrl-p>",
      },
      {
        desc = " Find word",
        action = "Telescope live_grep",
        shortcut = "<ctrl-g>",
      },
    },
  },
  hide = {
    statusline = false,
    tabline = false,
    winbar = false,
  },
}
