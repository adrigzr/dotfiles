if &filetype !=# 'coffee' || v:version < 700
  finish
endif

setlocal foldmethod=indent

let b:undo_ftplugin .= '|setlocal foldmethod<'
