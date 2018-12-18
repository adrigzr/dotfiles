if &filetype !=# 'qf' || v:version < 700
  finish
endif

nnoremap <silent> <buffer> <C-p>
      \ :<C-U>call quickfixed#older()<CR>
nnoremap <silent> <buffer> <C-n>
      \ :<C-U>call quickfixed#newer()<CR>

let b:undo_ftplugin .= '|nunmap <buffer> <C-p>'
      \ . '|nunmap <buffer> <C-n>'
