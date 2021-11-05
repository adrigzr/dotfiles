if !exists('g:loaded_coc_fzf')
  finish
endif

" nnoremap <silent> <leader><leader> :<C-u>CocFzfList<CR>
nnoremap <silent> <leader>ld       :<C-u>CocFzfList diagnostics<CR>
nnoremap <silent> <leader>lb       :<C-u>CocFzfList diagnostics --current-buf<CR>
nnoremap <silent> <leader>lc       :<C-u>CocFzfList commands<CR>
nnoremap <silent> <leader>le       :<C-u>CocFzfList extensions<CR>
nnoremap <silent> <leader>la       :<C-u>CocFzfList actions<CR>
" nnoremap <silent> <leader>ll       :<C-u>CocFzfList location<CR>
" nnoremap <silent> <leader>o       :<C-u>CocFzfList outline<CR>
nnoremap <silent> <leader>ls       :<C-u>CocFzfList symbols<CR>
nnoremap <silent> <leader>lp       :<C-u>CocFzfList<CR>
