local ls = require "luasnip"
local fmt = require("luasnip.extras.fmt").fmt
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("typescript", {
  s(
    "beforeEach",
    fmt(
      [[
        beforeEach(() => {{
          {}
        }});
      ]],
      { i(1) }
    )
  ),
  s(
    "afterEach",
    fmt(
      [[
        afterEach(() => {{
          {}
        }});
      ]],
      { i(1) }
    )
  ),
})
