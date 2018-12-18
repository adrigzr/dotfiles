autocmd filetypedetect BufRead,BufNewFile
      \ ?*.nu
      \,?*.nujson
      \,Nukefile
      \ setfiletype nu
