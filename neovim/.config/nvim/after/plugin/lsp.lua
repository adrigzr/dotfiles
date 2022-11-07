local exists, lspconfig = pcall(require, "lspconfig")

if not exists then
  return
end

local lspinstaller = require "nvim-lsp-installer"
local util = require "lspconfig/util"
local null_ls = require "null-ls"
local sign_define = vim.fn.sign_define
local custom_lsp_group = vim.api.nvim_create_augroup("custom_lsp", {})
local custom_lsp = require "custom.util.lsp"
local bind = require("custom.util.misc").bind
local inlayHints = require "lsp-inlayhints"
local rustTools = require "rust-tools"
local lspLines = require "lsp_lines"
local telescope_builtin = require "telescope.builtin"
local typescript = require "typescript"

-- Debugging
-- vim.lsp.set_log_level "debug"

-- Mappings
vim.keymap.set("n", "<leader>vi", "<cmd>LspInstallInfo<cr>", { desc = "Show lsp install info" })

-- Diagnostics
vim.diagnostic.config {
  virtual_text = true,
  virtual_lines = false,
  severity_sort = true,
}

-- Redefine diagnostics signs
sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError", numhl = "DiagnosticSignError" })
sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn", numhl = "DiagnosticSignWarn" })
sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo", numhl = "DiagnosticSignInfo" })
sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint", numhl = "DiagnosticSignHint" })

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = custom_lsp_group,
  callback = function()
    custom_lsp.add_missing_imports { sync = true }
    -- custom_lsp.remove_unused { sync = true }
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
    -- require("nvim-lightbulb").update_lightbulb {
    --   sign = { enabled = false },
    --   virtual_text = { enabled = true, text = "", hl_mode = "combine" },
    -- }
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

-- Not working.
local function range_code_action()
  -- Send <CR> to force get last visual range.
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<cr>", true, false, true), "v", false)

  local params = vim.lsp.util.make_given_range_params()
  local range = {
    start = { params.range.start.line + 1, params.range.start.character + 1 },
    ["end"] = { params.range["end"].line + 1, params.range["end"].character + 1 },
  }

  vim.lsp.buf.code_action { range = range }
end

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
  map(
    "n",
    "[d",
    bind(vim.diagnostic.goto_prev, { { float = { border = "rounded" } } }),
    { desc = "Go to previous diagnostic" }
  )
  map(
    "n",
    "]d",
    bind(vim.diagnostic.goto_next, { { float = { border = "rounded" } } }),
    { desc = "Go to next diagnostic" }
  )
  map("n", "<C-]>", custom_lsp.goto_definition, { desc = "Go to definition" })
  map({ "n", "v" }, "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
  map("n", "<leader>cf", bind(custom_lsp.format, { { async = true } }), { desc = "Format document" })
  map("n", "<leader>ca", bind(vim.lsp.buf.code_action, { { apply = true } }), { desc = "Apply code action" })
  map("v", "<leader>ca", bind(vim.lsp.buf.code_action, { { apply = true } }), { desc = "Apply range code action" })
  map(
    "n",
    "<leader>qf",
    bind(vim.lsp.buf.code_action, { { context = { only = "quickfix" }, apply = true } }),
    { desc = "Apply quickfix code action" }
  )
  map("n", "<leader>ch", inlayHints.toggle, { desc = "Toggle inlay hints" })
  map("n", "<leader>cc", function()
    local config = vim.diagnostic.config()

    vim.diagnostic.config {
      virtual_text = not config.virtual_text,
      virtual_lines = not config.virtual_lines,
    }
  end, { desc = "Toggle diagnostics" })
  map("n", "<leader>cd", custom_lsp.remove_unused, { desc = "Remove unused code" })

  if client.server_capabilities.goto_definition == true then
    vim.bo.tagfunc = "v:lua.vim.lsp.tagfunc"
  end

  if client.server_capabilities.documentFormattingProvider == true then
    vim.bo.formatexpr = "v:lua.vim.lsp.formatexpr()"
  end

  inlayHints.on_attach(client, bufnr, false)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- CMP
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

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

null_ls.setup {
  on_attach = common_on_attach,
  handlers = handlers,
  diagnostics_format = "#{s}: #{m} (#{c}",
  sources = {
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.code_actions.proselint,
    null_ls.builtins.code_actions.refactoring,
    null_ls.builtins.code_actions.shellcheck,
    null_ls.builtins.diagnostics.alex,
    null_ls.builtins.diagnostics.cfn_lint,
    null_ls.builtins.diagnostics.proselint,
    require "custom.diagnostics.rubocop",
    -- null_ls.builtins.diagnostics.selene,
    null_ls.builtins.diagnostics.vale,
    null_ls.builtins.diagnostics.vint,
    -- null_ls.builtins.diagnostics.yamllint,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.rubocop,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.terraform_fmt,
    null_ls.builtins.hover.dictionary,
  },
}

lspinstaller.setup {
  automatic_installation = true,
}

inlayHints.setup {}

lspLines.setup()

local extension_path = vim.env.HOME .. "/.vscode/extensions/vadimcn.vscode-lldb-1.7.3/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

rustTools.setup {
  server = {
    on_attach = function(client, bufnr)
      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      common_on_attach(client, bufnr)

      map("n", "K", rustTools.hover_actions.hover_actions, { desc = "Hover actions" })
      map("n", "<leader>cg", rustTools.code_action_group.code_action_group, { desc = "Code action group" })
    end,
    handlers = handlers,
  },
  dap = {
    adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
  },
}

typescript.setup {
  server = {
    root_dir = util.root_pattern("tsconfig.json", "jsconfig.json", ".git"),
    init_options = {
      preferences = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = "none",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = false,
        includeInlayVariableTypeHints = true,
      },
    },
    settings = {
      completions = {
        completeFunctionCalls = true,
      },
    },
    on_attach = function(client, bufnr)
      -- Delegate on eslint
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      vim.keymap.set("n", "<leader>rf", "<cmd>TypescriptRenameFile<CR>", { buffer = bufnr })

      common_on_attach(client, bufnr)
    end,
    capabilities = capabilities,
    handlers = handlers,
  },
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
  "solargraph",
  "sumneko_lua",
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
          "!Or sequence",
          "!Join sequence",
          "!Ref scalar",
          "!Sub scalar",
          "!Not sequence",
          "!Condition scalar",
        },
      },
    }
  end

  lspconfig[server].setup(opts)
end
