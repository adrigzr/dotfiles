local exists, snacks = pcall(require, "snacks")

if not exists then
  return
end

snacks.setup {
  input = {},
  terminal = {},
  indent = {
    animate = { enabled = false },
  },
  dashboard = {
    preset = {
      header = table.concat({
        " █████╗ ██████╗ ██████╗ ██╗ ██████╗ ███████╗██████╗ ",
        "██╔══██╗██╔══██╗██╔══██╗██║██╔════╝ ╚══███╔╝██╔══██╗",
        "███████║██║  ██║██████╔╝██║██║  ███╗  ███╔╝ ██████╔╝",
        "██╔══██║██║  ██║██╔══██╗██║██║   ██║ ███╔╝  ██╔══██╗",
        "██║  ██║██████╔╝██║  ██║██║╚██████╔╝███████╗██║  ██║",
        "╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝",
      }, "\n"),
      keys = {
        { icon = " ", key = "n", desc = "New file", action = ":enew" },
        { icon = " ", key = "f", desc = "Find file", action = ":Telescope find_files" },
        { icon = " ", key = "g", desc = "Find word", action = ":Telescope live_grep" },
        { icon = " ", key = "r", desc = "Recent files", action = ":Telescope oldfiles" },
        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
      },
    },
  },
  notifier = {
    enabled = true,
  },
}
