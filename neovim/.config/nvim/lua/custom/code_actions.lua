local M = {}

-- Select the current line and run a prompt library command.
-- This ensures context.code is populated even from normal mode.
local function run_prompt(alias)
  local lnum = vim.api.nvim_win_get_cursor(0)[1]
  vim.cmd(lnum .. "," .. lnum .. "CodeCompanion /" .. alias)
end

-- In-process LSP server that provides AI code actions
local function start_server(dispatchers)
  local closing = false

  local function handle(method, params, callback)
    if method == "initialize" then
      callback(nil, {
        capabilities = {
          codeActionProvider = true,
        },
      })
    elseif method == "shutdown" then
      closing = true
      if callback then
        callback(nil, nil)
      end
    elseif method == "exit" then
      if dispatchers.on_exit then
        dispatchers.on_exit(0, 0)
      end
    elseif method == "textDocument/codeAction" then
      local bufnr = params.textDocument and params.textDocument.uri and vim.uri_to_bufnr(params.textDocument.uri)
      local lnum = params.range and params.range.start and params.range.start.line
      local has_diagnostics = bufnr and lnum and #vim.diagnostic.get(bufnr, { lnum = lnum }) > 0

      local actions = {
        {
          title = "  Fix code",
          kind = "quickfix",
          command = {
            title = "  Fix code",
            command = "ai.fixCode",
          },
        },
        {
          title = "  Explain code",
          kind = "quickfix",
          command = {
            title = "  Explain code",
            command = "ai.explainCode",
          },
        },
      }

      if has_diagnostics then
        table.insert(actions, {
          title = "  Explain LSP diagnostics",
          kind = "quickfix",
          command = {
            title = "  Explain LSP diagnostics",
            command = "ai.explainLsp",
          },
        })
      end

      if callback then
        callback(nil, actions)
      end
    else
      if callback then
        callback(nil, nil)
      end
    end

    return true, 1
  end

  return {
    request = function(method, params, callback)
      return handle(method, params, callback)
    end,
    notify = function(method, params)
      handle(method, params, nil)
      return true
    end,
    is_closing = function()
      return closing
    end,
    terminate = function()
      closing = true
    end,
  }
end

function M.setup()
  vim.lsp.commands["ai.fixCode"] = function()
    run_prompt "fix"
  end

  vim.lsp.commands["ai.explainCode"] = function()
    run_prompt "explain"
  end

  vim.lsp.commands["ai.explainLsp"] = function()
    run_prompt "lsp"
  end

  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("code_actions", {}),
    callback = function()
      -- vim.lsp.start reuses existing clients and attaches to new buffers
      vim.lsp.start {
        name = "code-actions",
        cmd = start_server,
        root_dir = vim.fn.getcwd(),
      }
    end,
  })
end

return M
