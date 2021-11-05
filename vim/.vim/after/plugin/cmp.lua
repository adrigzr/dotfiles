local exists, module = pcall(require, "cmp")

if not exists then
  return
end

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
      if module.visible() then
        module.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      else
        local copilot_keys = vim.fn["copilot#Accept"]()
        if copilot_keys ~= "" then
          vim.api.nvim_feedkeys(copilot_keys, "i", true)
        else
          fallback()
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
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'buffer' },
    { name = 'vsnip', priority = 9999 },
    { name = 'path' },
  }),
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
