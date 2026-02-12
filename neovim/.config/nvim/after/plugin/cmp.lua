local exists, blink = pcall(require, "blink.cmp")

if not exists then
  return
end

local copilot_suggestion = require "copilot.suggestion"
local luasnip = require "luasnip"

blink.setup {
  keymap = {
    preset = "none",
    ["<Tab>"] = {
      function(cmp)
        if cmp.is_visible() then
          return cmp.select_next()
        end
        if copilot_suggestion.is_visible() then
          copilot_suggestion.accept()
          return true
        end
        if luasnip.locally_jumpable(1) then
          luasnip.jump(1)
          return true
        end
      end,
      "fallback",
    },
    ["<S-Tab>"] = {
      function(cmp)
        if cmp.is_visible() then
          return cmp.select_prev()
        end
        if luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
          return true
        end
      end,
      "fallback",
    },
    ["<CR>"] = { "accept", "fallback" },
    ["<C-e>"] = {
      function(cmp)
        if cmp.is_visible() then
          return cmp.cancel()
        end
        if copilot_suggestion.is_visible() then
          copilot_suggestion.dismiss()
          return true
        end
      end,
      "fallback",
    },
    ["<C-d>"] = { "scroll_documentation_down", "fallback" },
    ["<C-f>"] = { "scroll_documentation_up", "fallback" },
    ["<C-s>"] = { "show", "fallback" },
  },
  snippets = { preset = "luasnip" },
  sources = {
    default = { "lsp", "snippets", "path", "buffer" },
    per_filetype = {
      codecompanion = { "codecompanion" },
    },
  },
  completion = {
    documentation = {
      auto_show = true,
      window = { border = "rounded" },
    },
    menu = {
      draw = {
        columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "source_name" } },
      },
    },
  },
  signature = { enabled = true },
}

-- Highlights
local augroup = vim.api.nvim_create_augroup("blink_cmp_theme", {})

vim.api.nvim_create_autocmd("ColorScheme", {
  group = augroup,
  callback = function()
    vim.api.nvim_set_hl(0, "BlinkCmpLabelDeprecated", { strikethrough = true })
  end,
})
