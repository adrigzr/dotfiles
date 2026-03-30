local ok, tsc = pcall(require, "tsc")

if not ok then
  return
end

tsc.setup {
  auto_open_qflist = true,
  auto_close_qflist = false,
  auto_focus_qflist = false,
  auto_start_watch_mode = false,
  use_trouble_qflist = true,
  use_diagnostics = false,
  enable_progress_notifications = true,
  flags = {
    noEmit = true,
    watch = false,
  },
}

vim.keymap.set("n", "<leader>ct", "<cmd>TSC<cr>", { desc = "Run project type-check" })
vim.keymap.set("n", "<leader>cs", "<cmd>TSCStop<cr>", { desc = "Stop project type-check" })
