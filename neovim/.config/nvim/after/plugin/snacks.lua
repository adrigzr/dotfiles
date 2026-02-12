local exists, snacks = pcall(require, "snacks")

if not exists then
  return
end

local trouble_ok, trouble_sources = pcall(require, "trouble.sources.snacks")

snacks.setup {
  input = {},
  terminal = {},
  indent = {
    animate = { enabled = false },
  },
  picker = {
    ui_select = true,
    sources = {
      files = {
        hidden = true,
        exclude = { ".git", "node_modules" },
      },
      grep = {
        hidden = true,
        exclude = { ".git", "node_modules", "yarn.lock" },
      },
    },
    actions = trouble_ok and trouble_sources.actions or {},
    win = {
      input = {
        keys = {
          ["<Esc>"] = { "close", mode = { "n", "i" } },
          ["<c-t>"] = trouble_ok and { "trouble_open", mode = { "n", "i" } } or nil,
        },
      },
    },
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
        {
          icon = " ",
          key = "f",
          desc = "Find file",
          action = function()
            Snacks.picker.files()
          end,
        },
        {
          icon = " ",
          key = "g",
          desc = "Find word",
          action = function()
            Snacks.picker.grep()
          end,
        },
        {
          icon = " ",
          key = "r",
          desc = "Recent files",
          action = function()
            Snacks.picker.recent()
          end,
        },
        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
      },
    },
  },
  styles = {
    notification = {
      wo = { wrap = true },
    }
  },
  notifier = {
    enabled = true,
  },
}

local map = vim.keymap.set

map("n", "<leader>nh", function()
  Snacks.notifier.show_history()
end, { desc = "Show notification history" })

map("n", "<leader>nd", function()
  Snacks.notifier.hide()
end, { desc = "Dismiss current notification" })
