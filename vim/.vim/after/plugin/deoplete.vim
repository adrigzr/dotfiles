if !exists('g:loaded_deoplete')
  finish
endif

" Configuration.
set shortmess+=c " Remove messages for deoplete completion (match x of y)
set completeopt+=noinsert

" Runtime configuration.
augroup deoplete_vim
  autocmd!
  autocmd VimEnter * call deoplete#custom#option({
        \ 'on_insert_enter': v:false,
        \ 'max_list': 10,
        \ })
  autocmd VimEnter * call deoplete#custom#var('omni', 'input_patterns', {
        \ 'tex': 'g:vimtex#re#deoplete'
        \ })
augroup END

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"

" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-y>" : "\<TAB>"

" <C-j><C-k> aliases.
inoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
