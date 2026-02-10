local augroup = vim.api.nvim_create_augroup("yank_highlight", {})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  callback = function()
    vim.highlight.on_yank { higroup = "Yank", timeout = 1000 }
  end,
})
