local exists, dial_map = pcall(require, "dial.map")

if not exists then
  return
end

local augend = require "dial.augend"
local config = require "dial.config"
local map = vim.keymap.set

config.augends:register_group {
  default = {
    augend.integer.alias.decimal_int,
    augend.integer.alias.hex,
    augend.integer.alias.binary,
    augend.date.alias["%Y/%m/%d"],
    augend.date.alias["%Y-%m-%d"],
    augend.semver.alias.semver,
    augend.constant.new {
      elements = { "true", "false" },
      word = true,
      cyclic = true,
    },
    augend.constant.new {
      elements = { "yes", "no" },
      word = true,
      cyclic = true,
    },
    augend.constant.new {
      elements = { "&&", "||" },
      word = false,
      cyclic = true,
    },
  },
}

map("n", "<C-a>", function()
  dial_map.manipulate("increment", "normal")
end, { desc = "Increment" })

map("n", "<C-x>", function()
  dial_map.manipulate("decrement", "normal")
end, { desc = "Decrement" })

map("v", "<C-a>", function()
  dial_map.manipulate("increment", "visual")
end, { desc = "Increment" })

map("v", "<C-x>", function()
  dial_map.manipulate("decrement", "visual")
end, { desc = "Decrement" })

map("v", "g<C-a>", function()
  dial_map.manipulate("increment", "gvisual")
end, { desc = "Increment sequence" })

map("v", "g<C-x>", function()
  dial_map.manipulate("decrement", "gvisual")
end, { desc = "Decrement sequence" })
