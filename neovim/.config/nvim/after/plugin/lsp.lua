local ok, custom_lsp = pcall(require, "custom.util.lsp")

if not ok then
  return
end

local bind = require("custom.util.misc").bind
local custom_lsp_group = vim.api.nvim_create_augroup("custom_lsp", {})

-- Mappings
vim.keymap.set("n", "<leader>vi", "<cmd>Mason<cr>", { desc = "Open Mason" })

-- Diagnostics
vim.diagnostic.config {
  float = {
    title = "Diagnostics",
    title_pos = "left",
    header = "",
  },
  virtual_text = true,
  virtual_lines = false,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "✗",
      [vim.diagnostic.severity.WARN] = "⚠",
      [vim.diagnostic.severity.INFO] = "ℹ",
      [vim.diagnostic.severity.HINT] = "",
    },
  },
}

-- Format on save (prefer conform, fall back to LSP)
vim.api.nvim_create_autocmd("BufWritePre", {
  group = custom_lsp_group,
  callback = function(ev)
    if vim.b[ev.buf].disable_autoformat then
      return
    end

    local ft = vim.bo.filetype

    if vim.tbl_contains({ "typescript", "typescriptreact", "javascript", "javascriptreact" }, ft) then
      custom_lsp.add_missing_imports { sync = true }
    end

    local conform_ok, conform = pcall(require, "conform")

    if conform_ok then
      conform.format { bufnr = ev.buf, lsp_fallback = true, timeout_ms = 3000 }
    else
      custom_lsp.format()
    end
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

-- Shared capabilities for all servers
-- blink.cmp merges its own capabilities via vim.lsp.config("*") when it loads,
-- so we only need to set the ufo folding range capability here.
vim.lsp.config("*", {
  capabilities = {
    textDocument = {
      foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      },
    },
  },
})

-- LSP attach handler for keymaps and per-client overrides
vim.api.nvim_create_autocmd("LspAttach", {
  group = custom_lsp_group,
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local bufnr = ev.buf

    if not client then
      return
    end

    -- Buffer options
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

    if client.server_capabilities.definitionProvider == true then
      vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
    end

    if client.server_capabilities.documentFormattingProvider == true then
      vim.bo[bufnr].formatexpr = "v:lua.vim.lsp.formatexpr()"
    end

    -- Per-client capability overrides
    local disable_formatting = { "lua_ls", "jsonls", "solargraph", "typescript-tools" }
    local enable_formatting = { "eslint", "ember" }

    if vim.tbl_contains(disable_formatting, client.name) then
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end

    if vim.tbl_contains(enable_formatting, client.name) then
      client.server_capabilities.documentFormattingProvider = true
      client.server_capabilities.documentRangeFormattingProvider = true
    end

    -- Buffer keymaps
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    local ignore_patterns = { "test", "mock" }

    local function filter_ignored(item)
      if item.file then
        for _, pat in ipairs(ignore_patterns) do
          if item.file:find(pat) then
            return false
          end
        end
      end
    end

    map("n", "gd", custom_lsp.goto_definition, { desc = "Go to definition" })
    map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declarations" })
    map("n", "gt", function()
      Snacks.picker.lsp_type_definitions { transform = filter_ignored }
    end, { desc = "Go to productive type definitions" })
    map("n", "gT", function()
      Snacks.picker.lsp_type_definitions()
    end, { desc = "Go to all type definitions" })
    map("n", "gm", function()
      Snacks.picker.lsp_implementations { transform = filter_ignored }
    end, { desc = "Go to productive implementations" })
    map("n", "gM", function()
      Snacks.picker.lsp_implementations()
    end, { desc = "Go to all implementations" })
    map("n", "gr", function()
      Snacks.picker.lsp_references { transform = filter_ignored }
    end, { desc = "Go to productive references" })
    map("n", "gR", function()
      Snacks.picker.lsp_references()
    end, { desc = "Go to all references" })
    map("n", "K", custom_lsp.show_info, { desc = "Show info" })
    map("n", "<C-]>", custom_lsp.goto_definition, { desc = "Go to definition" })
    map({ "n", "v" }, "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
    map("n", "<leader>cf", function()
      local conform_ok, conform = pcall(require, "conform")

      if conform_ok then
        conform.format { bufnr = bufnr, lsp_fallback = true, async = true }
      else
        custom_lsp.format { async = true }
      end
    end, { desc = "Format document" })
    map("n", "<leader>ca", bind(vim.lsp.buf.code_action, { { apply = false } }), { desc = "Apply code action" })
    map("v", "<leader>ca", bind(vim.lsp.buf.code_action, { { apply = false } }), { desc = "Apply range code action" })
    map(
      "n",
      "<leader>qf",
      bind(vim.lsp.buf.code_action, { { context = { only = "quickfix" }, apply = true } }),
      { desc = "Apply quickfix code action" }
    )
    map("n", "<leader>cv", function()
      local config = vim.diagnostic.config() or {}

      vim.diagnostic.config {
        virtual_lines = not config.virtual_lines,
      }
    end, { desc = "Toggle virtual lines diagnostics" })
    map("n", "<leader>cu", custom_lsp.remove_unused, { desc = "Remove unused code" })
  end,
})

-- TypeScript tools
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
  on_attach = function(_, bufnr)
    vim.keymap.set("n", "<leader>rf", "<cmd>TSToolsRenameFile<CR>", { buffer = bufnr, desc = "Rename file (TSTools)" })
  end,
}

-- Prevent typescript-tools from attaching to non-filesystem buffers (e.g. diffview://)
vim.lsp.config("typescript-tools", {
  root_dir = function(bufnr, on_dir)
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if not bufname:match "^/" and not bufname:match "^[a-zA-Z]:" then
      return
    end
    on_dir(require("typescript-tools.utils").get_root_dir(bufnr))
  end,
})

require("mason").setup()

-- ESLint v10 removed the FlatESLint export from eslint/use-at-your-own-risk.
-- When useFlatConfig is true, the server tries to import FlatESLint from that
-- path and fails silently (no diagnostics). Setting it to false makes the
-- server load eslint directly and use the loadESLint() API instead, which
-- handles flat config automatically in v8.57+, v9, and v10.
-- The before_init wrapper is needed because nvim-lspconfig's before_init hook
-- detects flat config files and sets useFlatConfig back to true unconditionally.
-- NOTE: vim.lsp.config() is used instead of lsp/eslint.lua because the latter
-- gets overridden by nvim-lspconfig defaults (later in rtp wins for lsp/*.lua).
local orig_eslint_before_init = vim.lsp.config.eslint.before_init
vim.lsp.config("eslint", {
  before_init = function(params, config)
    if orig_eslint_before_init then
      orig_eslint_before_init(params, config)
    end
    config.settings.experimental.useFlatConfig = false
  end,
  settings = {
    experimental = {
      useFlatConfig = false,
    },
  },
})

-- Enable LSP servers (configs in lsp/<server>.lua)
vim.lsp.enable {
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
