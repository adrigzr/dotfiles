"
" fast_escape.vim: Fast escape from insert mode.
"
" Author: Adrián González Rus <adrian.gonzalez.rus@bbva.com>
" License: Same as Vim itself
"
if exists('g:loaded_fast_escape') || has('gui_running')
  finish
endif
let g:loaded_fast_escape = 1

augroup fast_escape
  autocmd!
  au InsertEnter * set timeoutlen=0
  au InsertLeave * set timeoutlen=1000
augroup END
