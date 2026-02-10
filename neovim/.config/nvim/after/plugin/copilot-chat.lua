local exists, module = pcall(require, "CopilotChat")

if not exists then
  return
end

vim.keymap.set("n", "<leader>cce", "<cmd>CopilotChatExplain<cr>", { desc = "Copilot Chat Explain" })
vim.keymap.set("n", "<leader>ccr", "<cmd>CopilotChatReview<cr>", { desc = "Copilot Chat Review" })
vim.keymap.set("n", "<leader>ccf", "<cmd>CopilotChatFix<cr>", { desc = "Copilot Chat Fix" })
vim.keymap.set("n", "<leader>cco", "<cmd>CopilotChatOptimize<cr>", { desc = "Copilot Chat Optimize" })
vim.keymap.set("n", "<leader>ccd", "<cmd>CopilotChatDocs<cr>", { desc = "Copilot Chat Docs" })
vim.keymap.set("n", "<leader>cct", "<cmd>CopilotChatTests<cr>", { desc = "Copilot Chat Tests" })
vim.keymap.set("n", "<leader>cci", "<cmd>CopilotChatFixDiagnostic<cr>", { desc = "Copilot Chat Fix Diagnostic" })
vim.keymap.set("n", "<leader>ccc", "<cmd>CopilotChatCommit<cr>", { desc = "Copilot Chat Commit" })
vim.keymap.set("n", "<leader>ccs", "<cmd>CopilotChatCommitStaged<cr>", { desc = "Copilot Chat Commit Staged" })
