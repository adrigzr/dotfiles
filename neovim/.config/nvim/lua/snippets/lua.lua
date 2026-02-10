local ls = require "luasnip"
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("lua", {
  s(
    "reqtry",
    fmt(
      [[
        local exists, {} = pcall(require, "{}")

        if not exists then
          return
        end
      ]],
      {
      rep(1),
      i(1, "module"),
    }
    )
  ),
})
