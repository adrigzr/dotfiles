if &filetype !=# 'dot' || v:version < 700
  finish
endif

setlocal makeprg=dot\ -Tsvg\ \"%:p\"\ -o\ \"%:p:r.svg\"

let b:undo_ftplugin = '|setlocal makeprg<'
