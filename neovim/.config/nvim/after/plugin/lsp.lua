local exists, lspconfig = pcall(require, "lspconfig")

if not exists then
  return
end

local lspinstaller = require "nvim-lsp-installer"
local util = require "lspconfig/util"
local null_ls = require "null-ls"
-- local aerial = require "aerial"
local ts_utils = require "nvim-lsp-ts-utils"
local sign_define = vim.fn.sign_define
local custom_lsp_group = vim.api.nvim_create_augroup("custom_lsp", {})

-- Debugging
-- vim.lsp.set_log_level "debug"

-- Diagnostics
vim.diagnostic.config {
  virtual_text = true,
  severity_sort = true,
}

-- aerial.setup {
--   default_direction = "float",
--   close_on_select = true,
-- }

-- Redefine diagnostics signs
sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError", numhl = "DiagnosticSignError" })
sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn", numhl = "DiagnosticSignWarn" })
sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo", numhl = "DiagnosticSignInfo" })
sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint", numhl = "DiagnosticSignHint" })

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = custom_lsp_group,
  callback = function()
    require("custom.util.lsp").format()
  end,
})

-- Custom colors
vim.api.nvim_create_autocmd("ColorScheme", {
  group = custom_lsp_group,
  callback = function()
    vim.cmd "highlight DiagnosticDeprecatedTag gui=strikethrough"
  end,
})

-- Show diagnostics when hovering over an error
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  group = custom_lsp_group,
  callback = function()
    require("custom.util.lsp").hover()
    require("nvim-lightbulb").update_lightbulb {
      sign = { enabled = false },
      virtual_text = { enabled = true, text = "", hl_mode = "combine" },
    }
  end,
})

-- Clear references when cursor moved
vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
  group = custom_lsp_group,
  callback = function()
    vim.lsp.buf.clear_references()
  end,
})

-- Custom diagnostic handlers
vim.diagnostic.handlers["lsp_tags"] = require("custom.util.diagnostic").lsp_tags_handler

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local function common_on_attach(client, _)
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
  vim.keymap.set("n", "<leader>cf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
  vim.keymap.set("n", "<leader>cd", "<cmd>TroubleToggle document_diagnostics<CR>", opts)
  vim.keymap.set("n", "<leader>cw", "<cmd>TroubleToggle workspace_diagnostics<CR>", opts)
  -- vim.keymap.set("n", "<leader>cs", "<cmd>AerialToggle<CR>", opts)
  -- vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", opts)
  -- vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", opts)
  -- vim.keymap.set("n", "[[", "<cmd>AerialPrevUp<CR>", opts)
  -- vim.keymap.set("n", "]]", "<cmd>AerialNextUp<CR>", opts)

  if client.server_capabilities.goto_definition == true then
    vim.bo.tagfunc = "v:lua.vim.lsp.tagfunc"
  end

  if client.server_capabilities.documentFormattingProvider == true then
    vim.bo.formatexpr = "v:lua.vim.lsp.formatexpr()"
  end

  -- Configure aerial
  -- aerial.on_attach(client, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- CMP
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

-- Pretty folds (ufo)
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

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
    null_ls.builtins.diagnostics.vale,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.stylua,
    require "custom.diagnostics.rubocop",
    null_ls.builtins.formatting.rubocop,
    null_ls.builtins.formatting.terraform_fmt,
  },
}

lspinstaller.setup {
  automatic_installation = true,
}

local servers = {
  "bashls",
  "cssls",
  "dockerls",
  "dotls",
  "eslint",
  "graphql",
  "html",
  "jsonls",
  "pyright",
  "rust_analyzer",
  "solargraph",
  "sumneko_lua",
  "tsserver",
  "vimls",
  "yamlls",
}

for _, server in pairs(servers) do
  -- LSP Options: https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
  local opts = {
    on_attach = common_on_attach,
    capabilities = capabilities,
    handlers = handlers,
  }

  if server == "sumneko_lua" then
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

    opts.on_attach = function(client, bufnr)
      -- Delegate on stylua
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      common_on_attach(client, bufnr)
    end
  end

  -- Enable formatting
  if vim.tbl_contains({ "eslint", "ember" }, server) then
    opts.on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = true
      client.server_capabilities.documentRangeFormattingProvider = true
      common_on_attach(client, bufnr)
    end
  end

  -- Disable formatting
  if vim.tbl_contains({ "jsonls" }, server) then
    opts.on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      common_on_attach(client, bufnr)
    end
  end

  if server == "tsserver" then
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
      -- Delegate on eslint
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
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

  if server == "jsonls" then
    opts.settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    }
  end

  if server == "yamlls" then
    opts.settings = {
      yaml = {
        trace = {
          server = "verbose",
        },
        schemas = {
          ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
          ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "/.gitlab/ci/*.yml",
          ["https://raw.githubusercontent.com/awslabs/goformation/master/schema/sam.schema.json"] = "template.yaml",
        },
        customTags = {
          "!Equals sequence",
          "!GetAtt scalar",
          "!If sequence",
          "!Or sequence",
          "!Join sequence",
          "!Ref scalar",
          "!Sub scalar",
          "!Not sequence",
        },
      },
    }
  end

  lspconfig[server].setup(opts)
end
