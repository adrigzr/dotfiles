"
" incsearch_highlight.vim: When hlsearch is disabled, enable it when searching
" only.
"
" Author: Adrián González Rus <adrian.gonzalez.rus@bbva.com>
" License: Same as Vim itself
"
if exists('g:loaded_incsearch_highlight') ||
      \ v:version < 801 ||
      \ (v:version == 800 && !has('patch1206'))
  finish
endif
let g:loaded_incsearch_highlight = 1

" Function.
function! s:toggle_hls(on_enter) abort
  if a:on_enter
    let s:hls_on = &hlsearch
    set hlsearch
  else
    if exists('s:hls_on')
      exe 'set '.(s:hls_on ? '' : 'no').'hls'
      unlet! s:hls_on
    endif
  endif
endfunction

" Commands.
augroup incsearch_highlight
  autocmd!
  autocmd CmdlineEnter [/\?] call s:toggle_hls(1)
  autocmd CmdlineLeave [/\?] call s:toggle_hls(0)
augroup END
