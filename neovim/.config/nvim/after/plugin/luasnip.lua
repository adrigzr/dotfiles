local exists = pcall(require, "luasnip")

if not exists then
  return
end

local ls = require "luasnip"
local types = require "luasnip.util.types"

ls.config.set_config {
  history = true,
  update_events = "TextChanged,TextChangedI",
  delete_check_events = "TextChanged",
  ext_opts = {
    [types.insertNode] = {
      active = {
        virt_text = { { "⇐ Insert", "Comment" } },
      },
    },
    [types.choiceNode] = {
      active = {
        virt_text = { { "⇐ Choice", "Comment" } },
      },
    },
  },
  ext_base_prio = 300,
  ext_prio_increase = 1,
  enable_autosnippets = true,
}

-- Extend snippets
ls.filetype_extend("typescript", { "javascript" })

-- Load other snippets
require("luasnip.loaders.from_lua").lazy_load { paths = "./lua/snippets" }
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load()
