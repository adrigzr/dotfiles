local exists, todo_comments = pcall(require, "todo-comments")

if not exists then
  return
end

todo_comments.setup()

vim.keymap.set("n", "<leader>st", "<cmd>TodoTrouble<cr>", { desc = "Show TODOs in Trouble" })
