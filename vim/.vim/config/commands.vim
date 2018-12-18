" Override system filetype.vim
if exists('g:did_load_commands')
  finish
endif
let g:did_load_commands = 1

" Format json.
command! -nargs=0 FormatJSON execute "%!python -m json.tool"

" Copy current file path.
command! -nargs=0 CopyPath execute "let @+ = expand('%')"
