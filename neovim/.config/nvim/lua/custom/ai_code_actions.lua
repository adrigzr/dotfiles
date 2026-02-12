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

local function ask_ai(prompt)
  local ok, codecompanion = pcall(require, "codecompanion")

  if not ok then
    vim.notify("CodeCompanion is not available", vim.log.levels.ERROR)
    return
  end

  codecompanion.chat {
    user_prompt = prompt,
    auto_submit = true,
  }
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
      local diags = bufnr and lnum and vim.diagnostic.get(bufnr, { lnum = lnum }) or {}
      local diagnostic_text = #diags > 0 and format_diagnostics(diags) or nil

      local actions = {
        {
          title = "AI: Fix code",
          kind = "quickfix",
          command = {
            title = "AI: Fix code",
            command = "ai.fixCode",
            arguments = { diagnostic_text },
          },
        },
        {
          title = "AI: Explain code",
          kind = "quickfix",
          command = {
            title = "AI: Explain code",
            command = "ai.explainCode",
            arguments = { diagnostic_text },
          },
        },
      }

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

  vim.lsp.commands["ai.fixCode"] = function(command)
    local diagnostic_text = command.arguments and command.arguments[1]

    if diagnostic_text then
      ask_ai(
        "There is a problem in this code. Identify the issues and rewrite the code with fixes. Explain what was wrong and how your changes address the problems.\n\nDiagnostic issues:\n"
          .. diagnostic_text
      )
    else
      ask_ai "There is a problem in this code. Identify the issues and rewrite the code with fixes. Explain what was wrong and how your changes address the problems."
    end
  end

  vim.lsp.commands["ai.explainCode"] = function(command)
    local diagnostic_text = command.arguments and command.arguments[1]

    if diagnostic_text then
      ask_ai("Explain this code and the following diagnostic issues:\n" .. diagnostic_text)
    else
      ask_ai "Explain this code. How does it work and what is its purpose?"
    end
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
