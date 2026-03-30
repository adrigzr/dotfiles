local blink = require "blink.cmp"
local luasnip = require "luasnip"

blink.setup {
  keymap = {
    preset = "none",
    ["<Tab>"] = {
      function(cmp)
        if cmp.is_visible() then
          return cmp.select_next()
        end
        local cs_ok, copilot_suggestion = pcall(require, "copilot.suggestion")
        if cs_ok and copilot_suggestion.is_visible() then
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
        local cs_ok, copilot_suggestion = pcall(require, "copilot.suggestion")
        if cs_ok and copilot_suggestion.is_visible() then
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
      markdown = { "obsidian", "lsp", "snippets", "path", "buffer" },
    },
  },
  completion = {
    list = {
      selection = {
        preselect = false,
        auto_insert = true,
      },
    },
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
  cmdline = {
    keymap = {
      preset = "cmdline",
      ["<Tab>"] = { "show", "select_next", "fallback" },
      ["<S-Tab>"] = { "show", "select_prev", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
    },
    completion = {
      list = {
        selection = {
          preselect = false,
          auto_insert = true,
        },
      },
    },
  },
}

-- Highlights
local augroup = vim.api.nvim_create_augroup("blink_cmp_theme", {})

vim.api.nvim_create_autocmd("ColorScheme", {
  group = augroup,
  callback = function()
    vim.api.nvim_set_hl(0, "BlinkCmpLabelDeprecated", { strikethrough = true })
  end,
})
