if exists('g:loaded_term_startinsert')
  finish
endif

let g:loaded_term_startinsert = 1

augroup term_startinsert
  autocmd!
  autocmd TermOpen * startinsert
augroup END
