" Create a pulse on current line.
function! pulse#Pulse() abort
  redir => l:old_hi
  silent execute 'hi CursorLine'
  redir END
  let l:old_hi = split(l:old_hi, "\n")[0]
  let l:old_hi = substitute(l:old_hi, 'xxx', '', '')

  let l:steps = 8
  let l:width = 1
  let l:start = l:width
  let l:end = l:steps * l:width
  let l:color = 233

  for l:i in range(l:start, l:end, l:width)
    execute 'hi CursorLine ctermbg=' . (l:color + l:i)
    redraw
    sleep 6m
  endfor
  for l:i in range(l:end, l:start, -1 * l:width)
    execute 'hi CursorLine ctermbg=' . (l:color + l:i)
    redraw
    sleep 6m
  endfor

  execute 'hi ' . l:old_hi
endfunction
