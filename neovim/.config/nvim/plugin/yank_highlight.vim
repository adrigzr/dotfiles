augroup yank_highlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup = "Yank", timeout = 1000 }
augroup END
