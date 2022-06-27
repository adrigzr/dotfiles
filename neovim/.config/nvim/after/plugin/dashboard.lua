local exists, dashboard = pcall(require, "dashboard")

if not exists then
  return
end

dashboard.custom_header = {
  " █████╗ ██████╗ ██████╗ ██╗ ██████╗ ███████╗██████╗ ",
  "██╔══██╗██╔══██╗██╔══██╗██║██╔════╝ ╚══███╔╝██╔══██╗",
  "███████║██║  ██║██████╔╝██║██║  ███╗  ███╔╝ ██████╔╝",
  "██╔══██║██║  ██║██╔══██╗██║██║   ██║ ███╔╝  ██╔══██╗",
  "██║  ██║██████╔╝██║  ██║██║╚██████╔╝███████╗██║  ██║",
  "╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝",
  "",
  "",
}

dashboard.custom_center = {
  {
    icon = "  ",
    desc = "Recently opened files                   ",
    action = "Telescope oldfiles",
    shortcut = "         ",
  },
  {
    icon = "  ",
    desc = "New file                                ",
    action = "enew",
    shortcut = "<space>bt",
  },
  {
    icon = "  ",
    desc = "Find file                               ",
    action = "Telescope find_files",
    shortcut = " <ctrl-p>",
  },
  {
    icon = "  ",
    desc = "Find word                               ",
    action = "Telescope live_grep",
    shortcut = " <ctrl-g>",
  },
}
