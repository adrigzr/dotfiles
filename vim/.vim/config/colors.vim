"
" colors.vim: Overrides themes.
"
" Author: Adrián González Rus <adrian.gonzalez.rus@bbva.com>
" License: Same as Vim itself
"
if exists('g:loaded_colors')
  finish
endif
let g:loaded_colors = 1

let g:onedark_terminal_italics = 1

augroup colors
  autocmd!
  " Transparent background {{{
  autocmd ColorScheme *
        \ highlight Normal guibg=NONE ctermbg=NONE |
        \ highlight EndOfBuffer guibg=NONE ctermbg=NONE |
        \ highlight NonText guibg=NONE ctermbg=NONE
  " }}}
  " Color (see listchars) {{{
  autocmd ColorScheme *
        \ highlight NonText ctermfg=10 ctermbg=8 guifg=#000000 guibg=#000000 |
        \ highlight SpecialKey term=NONE cterm=NONE
  " }}}
  " Folded {{{
  autocmd ColorScheme *
        \ highlight Folded cterm=bold,underline ctermfg=12 guifg=Cyan
  " }}}
augroup END
