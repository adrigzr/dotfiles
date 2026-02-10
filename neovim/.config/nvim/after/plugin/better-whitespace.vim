if !exists('g:loaded_better_whitespace_plugin')
  finish
endif

augroup betterwhitespace_config
  autocmd!
  autocmd BufWritePre * StripWhitespace
  autocmd ColorScheme * highlight ExtraWhitespace guibg=#e86671
augroup END
