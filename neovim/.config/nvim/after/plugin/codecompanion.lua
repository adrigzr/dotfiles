local exists, codecompanion = pcall(require, "codecompanion")

if not exists then
  return
end

-- Required for live buffer reloading when tools edit files
vim.o.autoread = true

codecompanion.setup {
  interactions = {
    chat = {
      adapter = {
        name = "opencode",
        model = "claude-opus-4-6",
      },
    },
    inline = {
      adapter = {
        name = "anthropic",
        model = "claude-opus-4-6",
      },
    },
    cmd = {
      adapter = {
        name = "anthropic",
        model = "claude-opus-4-6",
      },
    },
  },
  display = {
    action_palette = {
      provider = "snacks",
    },
    chat = {
      window = {
        layout = "vertical",
      },
    },
  },
}

require("custom.ai_code_actions").setup()

local map = vim.keymap.set

-- Action palette
map({ "n", "v" }, "<leader>aa", "<cmd>CodeCompanionActions<cr>", { desc = "AI action palette" })

-- Chat
map({ "n", "v" }, "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Toggle AI chat" })
map("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { desc = "Add selection to AI chat" })

-- Inline assistant
map({ "n", "v" }, "<leader>ai", "<cmd>CodeCompanion<cr>", { desc = "AI inline assistant" })

-- Prompt library shortcuts (visual mode)
map("v", "<leader>ae", "<cmd>CodeCompanion /explain<cr>", { desc = "AI explain code" })
map("v", "<leader>af", "<cmd>CodeCompanion /fix<cr>", { desc = "AI fix code" })
map("v", "<leader>al", "<cmd>CodeCompanion /lsp<cr>", { desc = "AI explain LSP diagnostics" })
map("v", "<leader>at", "<cmd>CodeCompanion /tests<cr>", { desc = "AI generate tests" })

-- Commit message (uses staged diff)
map("n", "<leader>ak", "<cmd>CodeCompanion /commit<cr>", { desc = "AI commit message" })

-- Explain diagnostic on current line
map("n", "<leader>ax", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
  local diagnostics = vim.diagnostic.get(bufnr, { lnum = lnum })

  if #diagnostics == 0 then
    vim.notify("No diagnostics on current line", vim.log.levels.WARN)
    return
  end

  local messages = {}

  for _, d in ipairs(diagnostics) do
    local entry = d.message

    if d.source then
      entry = entry .. " (" .. d.source .. ")"
    end

    table.insert(messages, entry)
  end

  require("codecompanion").chat {
    user_prompt = "Explain these diagnostic issues:\n" .. table.concat(messages, "\n"),
    auto_submit = true,
  }
end, { desc = "AI explain diagnostic" })
