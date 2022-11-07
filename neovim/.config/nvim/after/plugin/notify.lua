local exists, notify = pcall(require, "notify")

if not exists then
  return
end

local colors = require("custom.theme").colors

notify.setup {
  background_colour = colors.bg0,
}

vim.notify = notify
