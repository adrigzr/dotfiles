local exists, module = pcall(require, "scrollbar")

if not exists then
  return
end

local colors = require("custom.theme").colors

module.setup {
  handle = {
    color = colors.light_grey,
  },
  excluded_filetypes = {
    "NvimTree",
  },
}
