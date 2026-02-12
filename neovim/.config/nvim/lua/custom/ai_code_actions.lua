local M = {}

local function format_diagnostics(diagnostics)
  local messages = {}

  for _, d in ipairs(diagnostics) do
    local entry = d.message or ""

    if d.source then
      entry = entry .. " (" .. d.source .. ")"
    end

    table.insert(messages, entry)
  end

  return table.concat(messages, "\n")
end

local function ask_ai(prompt, diagnostic_text)
  local ok, codecompanion = pcall(require, "codecompanion")

  if not ok then
    vim.notify("CodeCompanion is not available", vim.log.levels.ERROR)
    return
  end

  codecompanion.ask(prompt .. "\n" .. diagnostic_text, {
    interaction = "chat",
  })
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
      local actions = {}

      -- Neovim scopes params.context.diagnostics to the requesting client's
      -- namespace. Since this server never publishes diagnostics, that list is
      -- always empty. Query all sources via vim.diagnostic.get() instead.
      local bufnr = params.textDocument and params.textDocument.uri and vim.uri_to_bufnr(params.textDocument.uri)
      local lnum = params.range and params.range.start and params.range.start.line
      local diags = bufnr and lnum and vim.diagnostic.get(bufnr, { lnum = lnum }) or {}

      if #diags > 0 then
        local diagnostic_text = format_diagnostics(diags)

        table.insert(actions, {
          title = "AI: Fix diagnostic",
          kind = "quickfix",
          command = {
            title = "AI: Fix diagnostic",
            command = "ai.fixDiagnostic",
            arguments = { diagnostic_text },
          },
        })

        table.insert(actions, {
          title = "AI: Explain diagnostic",
          kind = "quickfix",
          command = {
            title = "AI: Explain diagnostic",
            command = "ai.explainDiagnostic",
            arguments = { diagnostic_text },
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

  vim.lsp.commands["ai.fixDiagnostic"] = function(command)
    local diagnostic_text = command.arguments and command.arguments[1] or ""
    ask_ai(
      "There is a problem in this code. Identify the issues and rewrite the code with fixes. Explain what was wrong and how your changes address the problems.\n\nDiagnostic issues:",
      diagnostic_text
    )
  end

  vim.lsp.commands["ai.explainDiagnostic"] = function(command)
    local diagnostic_text = command.arguments and command.arguments[1] or ""
    ask_ai("Explain these diagnostic issues:", diagnostic_text)
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
