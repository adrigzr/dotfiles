local exists, cmp = pcall(require, "cmp")

if not exists then
  return
end

local lspkind = require "lspkind"
local util = require "custom.util"
local cmp_buffer = require "cmp_buffer"
local luasnip = require "luasnip"

-- Highlights
vim.cmd [[
  augroup cmp_theme
    autocmd!
    autocmd ColorScheme * highlight CmpItemAbbrDeprecated gui=strikethrough cterm=strikethrough
  augroup END
]]

local sources = {
  luasnip = { name = "luasnip", priority = 9999 },
  nvim_lsp = { name = "nvim_lsp" },
  nvim_lua = { name = "nvim_lua" },
  path = { name = "path" },
  calc = { name = "calc" },
  treesitter = { name = "treesitter" },
  spell = { name = "spell" },
  git = { name = "git" },
  buffer = {
    name = "buffer",
    option = {
      -- Add visible buffers to completion
      get_bufnrs = function()
        local bufs = {}
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          bufs[vim.api.nvim_win_get_buf(win)] = true
        end
        return vim.tbl_keys(bufs)
      end,
    },
  },
}

local tab_is = function(fallback)
  -- Go to next item if cmp is visible
  if cmp.visible() then
    cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
  else
    local copilot_keys = vim.fn["copilot#Accept"]()

    -- Complete with copilot if there is any suggestion
    if copilot_keys ~= "" then
      vim.api.nvim_feedkeys(copilot_keys, "i", true)
      -- Expand snippet to next item
    elseif luasnip.jumpable(1) then
      luasnip.expand_or_jump()
      -- Insert tab if prev char is a space
    elseif util.misc.has_words_before() then
      cmp.complete()
    else
      fallback()
    end
  end
end

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-e>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.close()
      elseif luasnip.choice_active() then
        luasnip.change_choice()
      elseif vim.api.nvim_eval 'exists("b:_copilot.suggestions")' then
        vim.fn["copilot#Dismiss"]()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<Tab>"] = cmp.mapping {
      i = tab_is,
      s = tab_is,
      n = function(fallback)
        -- Expand snippet to next item
        if luasnip.jumpable(1) then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end,
    },
    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { "i", "s" }),
    ["<CR>"] = cmp.mapping.confirm(),
  },
  sources = cmp.config.sources {
    sources.luasnip,
    sources.nvim_lsp,
    sources.nvim_lua,
    sources.git,
    sources.buffer,
    sources.path,
    sources.calc,
    sources.spell,
    sources.treesitter,
  },
  window = {
    documentation = cmp.config.window.bordered(),
  },
  formatting = {
    deprecated = true,
    format = lspkind.cmp_format {
      with_text = true,
      maxwidth = 50,
      menu = {
        luasnip = "[Snip]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[Lua]",
        git = "[Git]",
        buffer = "[Buffer]",
        path = "[Path]",
        calc = "[Calc]",
        spell = "[Spell]",
        treesitter = "[Treesitter]",
        cmdline = "[CMD]",
      },
    },
  },
  sorting = {
    comparators = {
      function(...)
        cmp_buffer:compare_locality(...)
      end,
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
}

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline("/", {
--   sources = {
--     sources.buffer,
--   },
-- })

require("cmp_git").setup()

-- Insert ( after select function or method item)
local cmp_autopairs = require "nvim-autopairs.completion.cmp"

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
