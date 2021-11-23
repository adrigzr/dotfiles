local exists, module = pcall(require, "cmp")

if not exists then
  return
end

local lspkind = require "lspkind"
local util = require "custom.util"
local cmp_buffer = require "cmp_buffer"

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local sources = {
  nvim_lsp = { name = "nvim_lsp", max_item_count = 10 },
  nvim_lua = { name = "nvim_lua" },
  buffer = {
    name = "buffer",
    opts = {
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
  vsnip = { name = "vsnip", priority = 9999 },
  path = { name = "path" },
  calc = { name = "calc" },
  treesitter = { name = "treesitter" },
  spell = { name = "spell" },
}

module.setup {
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  mapping = {
    ["<C-d>"] = module.mapping(module.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-f>"] = module.mapping(module.mapping.scroll_docs(4), { "i", "c" }),
    -- ['<C-e>'] = module.mapping(module.mapping.close()),
    ["<C-e>"] = module.mapping(function(fallback)
      if module.visible() then
        module.close()
      elseif vim.b._copilot_suggestion then
        vim.fn["copilot#Dismiss"]()
      else
        fallback()
      end
    end, { "i", "s" }),
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
        elseif util.misc.check_backspace() then
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
    ["<CR>"] = module.mapping.confirm { select = true },
  },
  sources = module.config.sources {
    sources.nvim_lsp,
    sources.nvim_lua,
    sources.buffer,
    sources.vsnip,
    sources.path,
    sources.calc,
    sources.treesitter,
    sources.spell,
  },
  documentation = {
    border = "rounded",
  },
  formatting = {
    format = lspkind.cmp_format {
      with_text = true,
      maxwidth = 50,
      menu = {
        nvim_lsp = "[LSP]",
        nvim_lua = "[Lua]",
        buffer = "[Buffer]",
        vsnip = "[Snip]",
        path = "[Path]",
        cmdline = "[CMD]",
      },
    },
  },
  sorting = {
    comparators = {
      -- Distance based sorting
      function(...)
        return cmp_buffer:compare_locality(...)
      end,
    },
  },
}

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
module.setup.cmdline("/", {
  sources = {
    sources.buffer,
  },
})

-- Insert ( after select function or method item)
local cmp_autopairs = require "nvim-autopairs.completion.cmp"

module.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
