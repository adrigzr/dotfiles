local exists, module = pcall(require, "nvim-lsp-installer")

if not exists then
  return
end

local util = require('lspconfig/util')
local custom = require('custom/diagnostics')

-- Debugging
-- vim.lsp.set_log_level("debug")

-- Diagnostics
vim.diagnostic.config({
  virtual_text = false,
})

-- Redefine diagnostics signs
vim.cmd[[
	sign define DiagnosticSignError text=✗ texthl=DiagnosticSignError numhl=DiagnosticSignError
	sign define DiagnosticSignWarn text=⚠ texthl=DiagnosticSignWarn numhl=DiagnosticSignWarn
	sign define DiagnosticSignInfo text=ℹ texthl=DiagnosticSignInfo numhl=DiagnosticSignInfo
	sign define DiagnosticSignHint text= texthl=DiagnosticSignHint numhl=DiagnosticSignHint
]]

-- Format on save
vim.cmd[[
  augroup lsp_format
    autocmd!
    autocmd BufWritePre * lua vim.lsp.buf.formatting_seq_sync()
  augroup END
]]

-- Show diagnostics when hovering over an error
vim.cmd[[
  augroup lsp_diagnostics
    autocmd!
    autocmd CursorHold,CursorHoldI * lua require('custom/diagnostics').hover()
  augroup END
]]

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local function common_on_attach(_, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua require("custom/diagnostics").goto_definition()<CR>', opts)
  buf_set_keymap('n', 'gt', '<cmd>Telescope lsp_type_definitions<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev({ popup_opts = { border = require("custom/diagnostics").border }})<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next({ popup_opts = { border = require("custom/diagnostics").border }})<CR>', opts)
  buf_set_keymap('n', '<C-]>', '<cmd>lua require("custom/diagnostics").goto_definition()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua require("renamer").rename()<CR>', opts)
  buf_set_keymap('v', '<leader>rn', '<cmd>lua require("renamer").rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>Telescope lsp_code_actions<CR>', opts)
  buf_set_keymap('n', '<leader>cf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('n', '<leader>cd', '<cmd>TroubleToggle lsp_document_diagnostics<CR>', opts)
  buf_set_keymap('n', '<leader>cw', '<cmd>TroubleToggle lsp_workspace_diagnostics<CR>', opts)
  buf_set_keymap('n', '<leader>cs', '<cmd>Telescope lsp_document_symbols<CR>', opts)
end

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local handler_opts = {
  border = custom.border,
  close_events = custom.close_events,
  focusable = false,
}

module.on_server_ready(function(server)
  -- LSP Options: https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
  local opts = {
    on_attach = common_on_attach,
    capabilities = capabilities,
    handlers = {
      ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, handler_opts),
      ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, handler_opts),
    }
  }

  if server.name == 'sumneko_lua' then
    opts.settings = {
      Lua = {
        diagnostics = {
          globals = {
            vim = true,
          },
        },
      },
    }
  end

  if server.name == "eslint" then
    opts.on_attach = function (client, bufnr)
      -- Enable eslint formatting
      client.resolved_capabilities.document_formatting = true
      common_on_attach(client, bufnr)
    end
  end

  if server.name == "tsserver" then
    opts.root_dir = util.root_pattern("tsconfig.json", "jsconfig.json")
    opts.on_attach = function (client, bufnr)
      -- Disable tsserver formatting
      client.resolved_capabilities.document_formatting = false
      common_on_attach(client, bufnr)
    end
  end

  server:setup(opts)
end)

