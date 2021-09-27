"
" large_files.vim: Remove syntax when files are too large.
"
" Author: Adrián González Rus <adrian.gonzalez.rus@bbva.com>
" License: Same as Vim itself
"
if exists('g:loaded_large_files')
  finish
endif
let g:loaded_large_files = 1

let g:large_file = 1 * 1024 * 1024

augroup large_file
  autocmd!
  " autocmd BufReadPre * let f=getfsize(expand("<afile>")) | if f > g:large_file || f == -2 | call LargeFile() | else | call SmallFile() | endif
augroup END

function! LargeFile()
  " no syntax highlighting etc
  set eventignore+=FileType
  " save memory when other file is viewed
  setlocal bufhidden=unload
  " no backup file
  setlocal noswapfile
endfunction

function! SmallFile()
  " restore syntax
  set eventignore-=FileType
endfunction

