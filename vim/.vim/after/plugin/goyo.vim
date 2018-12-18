function! s:goyo_enter() abort " {{{
  setlocal formatoptions=t1
  setlocal smartindent
  setlocal spell
  setlocal spelllang=es_es
  setlocal noexpandtab
  setlocal wrap
  setlocal linebreak
  setlocal noshowmode
  setlocal noshowcmd
  setlocal scrolloff=999
endfunction " }}}

function! s:goyo_leave() abort " {{{
endfunction " }}}

augroup goyo_enter " {{{
  autocmd!
  au User GoyoEnter nested call <SID>goyo_enter()
  au User GoyoLeave nested call <SID>goyo_leave()
augroup END " }}}
