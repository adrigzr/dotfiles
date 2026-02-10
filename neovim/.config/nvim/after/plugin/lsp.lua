local custom_lsp_group = vim.api.nvim_create_augroup("custom_lsp", {})
local custom_lsp = require "custom.util.lsp"
local bind = require("custom.util.misc").bind
local telescope_builtin = require "telescope.builtin"

-- Mappings
vim.keymap.set("n", "<leader>vi", "<cmd>LspInstallInfo<cr>", { desc = "Show lsp install info" })

-- Diagnostics
vim.diagnostic.config {
  virtual_text = true,
  virtual_lines = false,
  severity_sort = true,
}

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = custom_lsp_group,
  callback = function()
    custom_lsp.add_missing_imports { sync = true }
    custom_lsp.format()
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
vim.api.nvim_create_autocmd({ "CursorHold" }, {
  group = custom_lsp_group,
  callback = function()
    require("custom.util.lsp").document_highlight()
    require("custom.util.lsp").show_line_diagnostics()
  end,
})

-- Show signature help
vim.api.nvim_create_autocmd({ "CursorHoldI", "CursorMovedI" }, {
  group = custom_lsp_group,
  callback = function()
    require("custom.util.lsp").show_signature_help()
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
local function common_on_attach(client, bufnr)
  local function map(mode, l, r, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, l, r, opts)
  end

  -- Enable completion triggered by <c-x><c-o>
  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

  local file_ignore_patterns = { "test", "mock" }

  -- Mappings.
  map("n", "gd", custom_lsp.goto_definition, { desc = "Go to definition" })
  map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declarations" })
  map(
    "n",
    "gt",
    bind(telescope_builtin.lsp_type_definitions, { { file_ignore_patterns = file_ignore_patterns } }),
    { desc = "Go to productive type definitions" }
  )
  map("n", "gT", telescope_builtin.lsp_type_definitions, { desc = "Go to all type definitions" })
  map(
    "n",
    "gm",
    bind(telescope_builtin.lsp_implementations, { { file_ignore_patterns = file_ignore_patterns } }),
    { desc = "Go to productive implementations" }
  )
  map("n", "gM", telescope_builtin.lsp_implementations, { desc = "Go to all implementations" })
  map(
    "n",
    "gr",
    bind(telescope_builtin.lsp_references, { { file_ignore_patterns = file_ignore_patterns } }),
    { desc = "Go to productive references" }
  )
  map("n", "gR", telescope_builtin.lsp_references, { desc = "Go to all references" })
  map("n", "K", custom_lsp.show_info, { desc = "Show info" })
  map("n", "[d", function()
    vim.diagnostic.jump { count = -1, float = { border = "rounded" } }
  end, { desc = "Go to previous diagnostic" })
  map("n", "]d", function()
    vim.diagnostic.jump { count = 1, float = { border = "rounded" } }
  end, { desc = "Go to next diagnostic" })
  map("n", "<C-]>", custom_lsp.goto_definition, { desc = "Go to definition" })
  map({ "n", "v" }, "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
  map("n", "<leader>cf", bind(custom_lsp.format, { { async = true } }), { desc = "Format document" })
  map("n", "<leader>ca", bind(vim.lsp.buf.code_action, { { apply = false } }), { desc = "Apply code action" })
  map("v", "<leader>ca", bind(vim.lsp.buf.code_action, { { apply = false } }), { desc = "Apply range code action" })
  map(
    "n",
    "<leader>qf",
    bind(vim.lsp.buf.code_action, { { context = { only = "quickfix" }, apply = true } }),
    { desc = "Apply quickfix code action" }
  )
  map("n", "<leader>cd", function()
    local config = vim.diagnostic.config()

    vim.diagnostic.config {
      virtual_text = not config.virtual_text,
      virtual_lines = not config.virtual_lines,
    }
  end, { desc = "Toggle diagnostics" })
  map("n", "<leader>cu", custom_lsp.remove_unused, { desc = "Remove unused code" })

  if client.server_capabilities.goto_definition == true then
    vim.bo.tagfunc = "v:lua.vim.lsp.tagfunc"
  end

  if client.server_capabilities.documentFormattingProvider == true then
    vim.bo.formatexpr = "v:lua.vim.lsp.formatexpr()"
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- CMP
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Pretty folds (ufo)
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
    close_events = require("custom.util.lsp").close_events,
    focusable = true,
  }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
    close_events = require("custom.util.lsp").close_events,
    focusable = false,
  }),
}

require("lsp_lines").setup()

require("typescript-tools").setup {
  settings = {
    complete_function_calls = false,
    tsserver_file_preferences = {
      includeInlayEnumMemberValueHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayParameterNameHints = "none",
      includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      includeInlayPropertyDeclarationTypeHints = false,
      includeInlayVariableTypeHints = true,
      importModuleSpecifierPreference = "relative",
    },
  },
  on_attach = function(client, bufnr)
    -- Delegate on eslint
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    vim.keymap.set("n", "<leader>rf", "<cmd>TSToolsRenameFile<CR>", { buffer = bufnr, desc = "Rename file (TSTools)" })

    common_on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  handlers = handlers,
}

require("mason").setup()

local servers = {
  "ansiblels",
  "bashls",
  "cssls",
  "cucumber_language_server",
  "dockerls",
  "dotls",
  "eslint",
  "graphql",
  "html",
  "jsonls",
  "lua_ls",
  "pyright",
  "solargraph",
  "terraform_lsp",
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

  if server == "cucumber_language_server" then
    opts.settings = {
      cucumber = {
        features = { "test/**/*.feature" },
        glue = { "test/**/*.ts" },
      },
    }
  end

  if server == "lua_ls" then
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
          checkThirdParty = false,
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
  if vim.tbl_contains({ "jsonls", "solargraph" }, server) then
    opts.on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
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
        schemas = {
          ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
          ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "/.gitlab/ci/*.yml",
          ["https://raw.githubusercontent.com/awslabs/goformation/master/schema/sam.schema.json"] = "template.yaml",
        },
        customTags = {
          "!Equals sequence",
          "!GetAtt scalar",
          "!If sequence",
          "!Split sequence",
          "!Select sequence",
          "!And sequence",
          "!Or sequence",
          "!Join sequence",
          "!Ref scalar",
          "!Sub scalar",
          "!Not sequence",
          "!Condition scalar",
          "!reference sequence",
        },
        format = {
          enable = true,
        },
      },
    }
  end

  vim.lsp.config(server, opts)
  vim.lsp.enable(server)
end
