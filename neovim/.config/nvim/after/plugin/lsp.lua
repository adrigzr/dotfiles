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
  virtual_text = false,
  virtual_lines = false,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = " ",
    },
  },
}

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = custom_lsp_group,
  callback = function()
    local ft = vim.bo.filetype

    if vim.tbl_contains({ "typescript", "typescriptreact", "javascript", "javascriptreact" }, ft) then
      custom_lsp.add_missing_imports { sync = true }
    end

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

-- Shared capabilities for all servers
local capabilities = require("blink.cmp").get_lsp_capabilities()

-- Pretty folds (ufo)
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

vim.lsp.config("*", {
  capabilities = capabilities,
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
  capabilities = capabilities,
}

require("mason").setup()

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
