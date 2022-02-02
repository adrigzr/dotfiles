local exists, module = pcall(require, "nvim-lsp-installer")

if not exists then
  return
end

local util = require "lspconfig/util"
local null_ls = require "null-ls"
local aerial = require "aerial"
local ts_utils = require "nvim-lsp-ts-utils"

-- Debugging
-- vim.lsp.set_log_level "debug"

-- Diagnostics
vim.diagnostic.config {
  virtual_text = false,
  severity_sort = true,
}

-- Redefine diagnostics signs
vim.cmd [[
	sign define DiagnosticSignError text= texthl=DiagnosticSignError numhl=DiagnosticSignError
	sign define DiagnosticSignWarn text=  texthl=DiagnosticSignWarn numhl=DiagnosticSignWarn
	sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo numhl=DiagnosticSignInfo
	sign define DiagnosticSignHint text= texthl=DiagnosticSignHint numhl=DiagnosticSignHint
]]

-- Format on save
vim.cmd [[
  augroup lsp_format
    autocmd!
    autocmd BufWritePre * lua vim.lsp.buf.formatting_seq_sync()
  augroup END
]]

-- Custom colors
vim.cmd [[
  augroup lsp_theme
    autocmd!
    autocmd ColorScheme * highlight DiagnosticDeprecatedTag gui=strikethrough
  augroup END
]]

-- Show diagnostics when hovering over an error
vim.cmd [[
  augroup lsp_diagnostics
    autocmd!
    autocmd CursorHold,CursorHoldI * lua require('custom.util.lsp').hover()
    autocmd CursorMoved,CursorMovedI * lua vim.lsp.buf.clear_references()
    autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb({ sign = { enabled = false }, virtual_text = { enabled = true, text = "", hl_mode = "combine" } })
  augroup END
]]

-- Custom diagnostic handlers
vim.diagnostic.handlers["lsp_tags"] = require("custom.util.diagnostic").lsp_tags_handler

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local function common_on_attach(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

  -- Mappings.
  local opts = { buffer = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.keymap.set("n", "gd", "<cmd>lua require('custom.util.lsp').goto_definition()<CR>", opts)
  vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
  vim.keymap.set("n", "gm", "<cmd>Telescope lsp_implementations<CR>", opts)
  vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
  vim.keymap.set("n", "K", "<cmd>lua require('custom.util.lsp').show_info()<CR>", opts)
  vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev({ float = { border = 'rounded' }})<CR>", opts)
  vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next({ float = { border = 'rounded' }})<CR>", opts)
  vim.keymap.set("n", "<C-]>", "<cmd>lua require('custom.util.lsp').goto_definition()<CR>", opts)
  vim.keymap.set("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.keymap.set("v", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  vim.keymap.set("n", "<leader>qf", "<cmd>lua vim.lsp.buf.code_action({ only = 'quickfix' })<CR>", opts)
  vim.keymap.set("n", "<leader>cf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  vim.keymap.set("n", "<leader>cd", "<cmd>TroubleToggle document_diagnostics<CR>", opts)
  vim.keymap.set("n", "<leader>cw", "<cmd>TroubleToggle workspace_diagnostics<CR>", opts)
  vim.keymap.set("n", "<leader>cs", "<cmd>AerialToggle<CR>", opts)

  if client.resolved_capabilities.goto_definition == true then
    vim.bo.tagfunc = "v:lua.vim.lsp.tagfunc"
  end

  if client.resolved_capabilities.document_formatting == true then
    vim.bo.formatexpr = "v:lua.vim.lsp.formatexpr()"
  end

  -- Configure aerial
  aerial.on_attach(client, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local handler_opts = {
  border = "rounded",
  close_events = require("custom.util.lsp").close_events,
  focusable = false,
}

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, handler_opts),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, handler_opts),
}

null_ls.setup {
  on_attach = common_on_attach,
  handlers = handlers,
  diagnostics_format = "#{s}: #{m} (#{c}",
  sources = {
    null_ls.builtins.diagnostics.selene,
    null_ls.builtins.diagnostics.vint,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.stylua,
  },
}

module.on_server_ready(function(server)
  -- LSP Options: https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
  local opts = {
    on_attach = common_on_attach,
    capabilities = capabilities,
    handlers = handlers,
  }

  if server.name == "sumneko_lua" then
    local runtime_path = vim.split(package.path, ";")

    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")

    opts.settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
          path = runtime_path,
        },
        diagnostics = {
          globals = {
            vim = true,
          },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
      },
    }
  end

  -- Enable formatting
  if vim.tbl_contains({ "eslint", "ember" }, server.name) then
    opts.on_attach = function(client, bufnr)
      client.resolved_capabilities.document_formatting = true
      common_on_attach(client, bufnr)
    end
  end

  -- Disable formatting
  if vim.tbl_contains({ "jsonls" }, server.name) then
    opts.on_attach = function(client, bufnr)
      client.resolved_capabilities.document_formatting = false
      common_on_attach(client, bufnr)
    end
  end

  if server.name == "tsserver" then
    opts.root_dir = util.root_pattern("tsconfig.json", "jsconfig.json", ".git")
    opts.init_options = vim.tbl_deep_extend("force", ts_utils.init_options, {
      preferences = {
        includeInlayParameterNameHints = "none",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = false,
      },
    })
    opts.settings = {
      completions = {
        completeFunctionCalls = true,
      },
    }
    opts.on_attach = function(client, bufnr)
      client.resolved_capabilities.document_formatting = false
      ts_utils.setup {
        enable_import_on_completion = true,
        filter_out_diagnostics_by_code = { 80001 },
        update_imports_on_move = true,
      }
      ts_utils.setup_client(client)
      vim.keymap.set("n", "<leader>rf", "<cmd>TSLspRenameFile<CR>", { buffer = bufnr })
      common_on_attach(client, bufnr)
    end
  end

  if server.name == "jsonls" then
    opts.settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
      },
    }
  end

  server:setup(opts)
end)
