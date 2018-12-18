if !exists('g:loaded_easy_align_plugin')
  finish
endif

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vnoremap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
nnoremap <Leader>a <Plug>(EasyAlign)
