local exists, module = pcall(require, "cmp")

if not exists then
  return
end

local lspkind = require('lspkind')
local custom = require('custom/diagnostics')

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

module.setup {
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  mapping = {
    ['<C-d>'] = module.mapping(module.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = module.mapping(module.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-e>'] = module.mapping(module.mapping.close()),
    ["<Tab>"] = module.mapping(function(fallback)
      -- Go to next item if cmp is visible
      if module.visible() then
        module.select_next_item()
      -- Expand snippet to next item
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      else
        local copilot_keys = vim.fn["copilot#Accept"]()

        -- Complete with copilot if there is any suggestion
        if copilot_keys ~= "" then
          vim.api.nvim_feedkeys(copilot_keys, "i", true)
        -- Insert tab if prev char is a space
        elseif custom.check_backspace() then
          fallback()
        -- Otherwise open cmp
        else
          module.complete()
        end
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = module.mapping(function()
      if module.visible() then
        module.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),
    ['<CR>'] = module.mapping.confirm({ select = true }),
  },
  sources = module.config.sources({
    { name = 'nvim_lsp', max_item_count = 10 },
    { name = 'nvim_lua' },
    { name = 'buffer' },
    { name = 'vsnip', priority = 9999 },
    { name = 'path' },
  }),
  documentation = {
    border = "rounded",
  },
  formatting = {
    format = lspkind.cmp_format({
      with_text = true,
      maxwidth = 50,
      menu = {
        nvim_lsp = "[LSP]",
        nvim_lua = "[Lua]",
        buffer = "[Buffer]",
        vsnip = "[Snip]",
        path = "[Path]",
        cmdline = "[CMD]",
      }
    })
  }
}

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
module.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- module.setup.cmdline(':', {
--   sources = module.config.sources({ { name = 'path' } }, { { name = 'cmdline' } })
-- })

