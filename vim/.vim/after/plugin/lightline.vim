if !exists('g:loaded_lightline')
  finish
endif

let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [
      \       [ 'mode', 'paste' ],
      \		    [ 'readonly', 'filename', 'modified' ],
      \		    [ 'gitbranch' ]
      \   ],
      \   'right': [
      \        [ 'aleerror', 'alewarning' ],
      \        [ 'lineinfo' ],
      \		     [ 'percent' ],
      \		     [ 'fileformat', 'fileencoding', 'filetype' ],
      \        [ 'gutentags' ],
      \   ]
      \ },
      \ 'component_function': {
      \   'readonly': 'LightlineReadonly',
      \   'gitbranch': 'LightlineGitBranch'
      \ },
      \ 'component_expand': {
      \	  'alewarning': 'LightlineAleWarning',
      \	  'aleerror': 'LightlineAleError',
      \   'gutentags': 'LightlineGutentags'
      \ },
      \ 'component_type': {
      \   'alewarning': 'warning',
      \   'aleerror': 'error',
      \ }
      \ }

function! LightlineReadonly() abort
    return &readonly ? '' : ''
endfunction

function! LightlineGitBranch() abort
  if exists('*fugitive#head')
    let branch = fugitive#head()
    return branch !=# '' ? ' '.branch : ''
  endif
  return ''
endfunction

function! LightlineAleCount() abort
  let l:bufnr = bufnr('%')
  return ale#statusline#Count(l:bufnr)
endfunction

function! LightlineAleWarning() abort

  let l:count = LightlineAleCount()
  return l:count.warning > 0 ? l:count.warning : ''
endfunction

function! LightlineAleError() abort
  let l:count = LightlineAleCount()
  return l:count.error > 0 ? l:count.error : ''
endfunction

function! LightlineGutentags() abort
  return gutentags#statusline()
endfunction

augroup lightline_update
  autocmd!
  autocmd User ALELintPOST call lightline#update()
  autocmd User GutentagsUpdating call lightline#update()
  autocmd User GutentagsUpdated call lightline#update()
augroup END
