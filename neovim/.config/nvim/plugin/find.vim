"
" find.vim: Create find command.
"
" Author: Adrián González Rus <adrian.gonzalez.rus@bbva.com>
" License: Same as Vim itself
"
if exists('g:loaded_find') || !executable('rg')
  finish
endif
let g:loaded_find = 1

scriptencoding utf-8

" Note we extract the column as well as the file and line number
set grepprg=rg\ --no-heading\ --vimgrep\ --smart-case\ --color=never\ --ignore-case\ --hidden
set grepformat=%f:%l:%c:%m,%f:%l:%m

" Make the command.
command! -nargs=+ -complete=dir Find execute 'silent grep!' <q-args> | copen | redraw!
