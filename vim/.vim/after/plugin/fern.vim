if !exists('g:fern_loaded')
  finish
endif

" Open tree.
nnoremap <leader>t :Fern . -drawer -reveal=%<CR>

function! s:init_fern() abort
  " Use 'select' instead of 'edit' for default 'open' action
  nmap <buffer> <Plug>(fern-action-open) <Plug>(fern-action-open:select)

  " Expand or collapse.
  nmap <buffer><silent><expr>
        \ <Plug>(fern-action-expand-or-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )

  " Expand folder instead of enter.
  nmap <buffer> <Plug>(fern-action-enter) <Plug>(fern-action-expand-or-collapse)

  " NEEDS 'christoomey/vim-tmux-navigator'
  " Fix left navigation
  nmap <buffer> <C-h> :TmuxNavigateLeft<cr>
  " Fix right navigation
  nmap <buffer> <C-l> :TmuxNavigateRight<cr>
  " Fix down navigation
  nmap <buffer> <C-j> :TmuxNavigateDown<cr>
  " Fix up navigation
  nmap <buffer> <C-k> :TmuxNavigateUp<cr>

  " Remove file.
  nmap <buffer> d <Plug>(fern-action-remove)
  " Exit buffer.
  nmap <buffer> q :<C-u>quit<CR>
endfunction

augroup fern-custom
  autocmd!
  autocmd FileType fern call s:init_fern()
augroup END

augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END
