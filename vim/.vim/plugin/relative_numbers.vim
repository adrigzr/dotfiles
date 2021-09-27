"
" relative_numbers.vim: Swap relative numbers on mode change.
"
" Author: Adrián González Rus <adrian.gonzalez.rus@bbva.com>
" License: Same as Vim itself
"
if exists('g:loaded_relative_numbers')
  finish
endif
let g:loaded_relative_numbers = 1

" augroup relative_numbers
"   autocmd!
"   autocmd BufEnter,FocusGained,InsertLeave * if &number | set relativenumber | endif
"   autocmd BufLeave,FocusLost,InsertEnter   * if &number | set norelativenumber | endif
" augroup END
