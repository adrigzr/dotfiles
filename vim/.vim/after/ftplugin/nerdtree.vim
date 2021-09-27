if &filetype !=# 'nerdtree' || v:version < 700
  finish
endif

" NEEDS 'christoomey/vim-tmux-navigator'
" Fix left navigation
nnoremap <buffer> <C-h> :TmuxNavigateLeft<cr>
" Fix right navigation
nnoremap <buffer> <C-l> :TmuxNavigateRight<cr>
" Fix down navigation
nnoremap <buffer> <C-j> :TmuxNavigateDown<cr>
" Fix up navigation
nnoremap <buffer> <C-k> :TmuxNavigateUp<cr>
