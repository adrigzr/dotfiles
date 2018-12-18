if !exists('g:loaded_neosnippet')
  finish
endif

" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
inoremap <C-s>     <Plug>(neosnippet_expand_or_jump)
snoremap <C-s>     <Plug>(neosnippet_expand_or_jump)
xnoremap <C-s>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
inoremap <C-s>     <Plug>(neosnippet_expand_or_jump)
snoremap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
