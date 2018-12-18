if !exists('g:loaded_vader')
  finish
endif

function! s:exercism_tests() abort
  if expand('%:e') ==# 'vim'
    let testfile = printf('%s/%s.vader', expand('%:p:h'),
          \ tr(expand('%:p:h:t'), '-', '_'))
    if !filereadable(testfile)
      echoerr 'File does not exist: '. testfile
      return
    endif
    source %
    execute 'Vader' testfile
  else
    let sourcefile = printf('%s/%s.vim', expand('%:p:h'),
          \ tr(expand('%:p:h:t'), '-', '_'))
    if !filereadable(sourcefile)
      echoerr 'File does not exist: '. sourcefile
      return
    endif
    execute 'source' sourcefile
    Vader
  endif
endfunction

augroup vader
  autocmd!
  autocmd BufRead,BufNewFile *.{vader,vim} command! -buffer Test call s:exercism_tests()
augroup END
