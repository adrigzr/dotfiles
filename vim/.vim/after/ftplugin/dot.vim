if &filetype !=# 'dot' || v:version < 700
  finish
endif

setlocal makeprg=dot\ -Tpng\ \"%:p\"\ -o\ \"%:p:r.png\"

let b:undo_ftplugin .= '|setlocal makeprg<'
