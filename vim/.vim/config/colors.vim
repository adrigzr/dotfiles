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

let g:onedark_style = 'dark'
let g:onedark_terminal_italics = 1

augroup colors
  autocmd!
  " Transparent background {{{
  " autocmd ColorScheme *
  "       \ highlight Normal guibg=NONE ctermbg=NONE |
  "       \ highlight EndOfBuffer guibg=NONE ctermbg=NONE |
  "       \ highlight NonText guibg=NONE ctermbg=NONE |
  "       \ highlight SignColumn guibg=NONE ctermbg=NONE
  " }}}
  " Color (see listchars) {{{
  " autocmd ColorScheme *
  "       \ highlight SpecialKey term=NONE cterm=NONE
        " \ highlight NonText ctermfg=10 ctermbg=8 guifg=#000000 guibg=#000000 |
  " }}}
  " Folded {{{
  " autocmd ColorScheme *
  "       \ highlight Folded cterm=bold,underline ctermfg=12 guifg=Cyan
  " }}}
  " VirtualText {{{
  " autocmd ColorScheme *
  "       \ call onedark#set_highlight("CocCodeLens", { "fg": onedark#GetColors().comment_grey }) |
  "       \ call onedark#set_highlight("ALEVirtualTextError", { "fg": onedark#GetColors().red }) |
  "       \ call onedark#set_highlight("ALEVirtualTextWarning", { "fg": onedark#GetColors().yellow })
  " }}}
augroup END
