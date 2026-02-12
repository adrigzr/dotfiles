local exists, module = pcall(require, "CopilotChat")

if not exists then
  return
end

require("custom.copilot_actions").setup()

vim.keymap.set("n", "<leader>cce", "<cmd>CopilotChatExplain<cr>", { desc = "Copilot Chat Explain" })
vim.keymap.set("n", "<leader>ccr", "<cmd>CopilotChatReview<cr>", { desc = "Copilot Chat Review" })
vim.keymap.set("n", "<leader>ccf", "<cmd>CopilotChatFix<cr>", { desc = "Copilot Chat Fix" })
vim.keymap.set("n", "<leader>cco", "<cmd>CopilotChatOptimize<cr>", { desc = "Copilot Chat Optimize" })
vim.keymap.set("n", "<leader>ccd", "<cmd>CopilotChatDocs<cr>", { desc = "Copilot Chat Docs" })
vim.keymap.set("n", "<leader>cct", "<cmd>CopilotChatTests<cr>", { desc = "Copilot Chat Tests" })
vim.keymap.set("n", "<leader>cci", "<cmd>CopilotChatFixDiagnostic<cr>", { desc = "Copilot Chat Fix Diagnostic" })
vim.keymap.set("n", "<leader>ccc", "<cmd>CopilotChatCommit<cr>", { desc = "Copilot Chat Commit" })
vim.keymap.set("n", "<leader>ccs", "<cmd>CopilotChatCommitStaged<cr>", { desc = "Copilot Chat Commit Staged" })

vim.keymap.set("n", "<leader>ccx", function()
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

  require("CopilotChat").ask("Explain these diagnostic issues:\n" .. table.concat(messages, "\n"), {
    resources = "buffer:active",
  })
end, { desc = "Copilot explain diagnostic" })
