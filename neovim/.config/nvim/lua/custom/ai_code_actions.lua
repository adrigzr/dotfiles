local M = {}

local function run_prompt(alias)
  local ok, codecompanion = pcall(require, "codecompanion")

  if not ok then
    vim.notify("CodeCompanion is not available", vim.log.levels.ERROR)
    return
  end

  codecompanion.prompt(alias)
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
          title = "AI: Fix code",
          kind = "quickfix",
          command = {
            title = "AI: Fix code",
            command = "ai.fixCode",
          },
        },
        {
          title = "AI: Explain code",
          kind = "quickfix",
          command = {
            title = "AI: Explain code",
            command = "ai.explainCode",
          },
        },
      }

      if has_diagnostics then
        table.insert(actions, {
          title = "AI: Explain LSP diagnostics",
          kind = "quickfix",
          command = {
            title = "AI: Explain LSP diagnostics",
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
  local client_id = nil

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
    group = vim.api.nvim_create_augroup("ai_code_actions", {}),
    callback = function(ev)
      if not client_id then
        client_id = vim.lsp.start {
          name = "ai-code-actions",
          cmd = start_server,
          root_dir = vim.fn.getcwd(),
        }
      else
        vim.lsp.buf_attach_client(ev.buf, client_id)
      end
    end,
  })
end

return M
