"
" pulse.vim: Create a pulse.
"
" Author: Adrián González Rus <adrian.gonzalez.rus@bbva.com>
" License: Same as Vim itself
"
if exists('g:loaded_pulse')
  finish
endif
let g:loaded_pulse = 1

nnoremap <Plug>(Pulse) pulse#Pulse()
