if !exists('g:loaded_lightline')
  finish
endif

let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'active': {
      \   'left': [
      \       [ 'mode', 'paste' ],
      \		    [ 'gitbranch' ],
      \		    [ 'path' ],
      \		    [ 'readonly', 'filename', 'modified' ],
      \       [ 'cocstatus' ],
      \   ],
      \   'right': [
      \        [ 'errors', 'warnings', 'hints' ],
      \        [ 'lineinfo' ],
      \		     [ 'percent' ],
      \		     [ 'fileformat', 'fileencoding', 'filetype' ],
      \   ]
      \ },
      \ 'inactive': {
      \   'left': [
      \		    [ 'path' ],
      \		    [ 'readonly', 'filename', 'modified' ]
      \   ],
      \   'right': [
      \        [ 'lineinfo' ],
      \		     [ 'percent' ],
      \		     [ 'fileformat', 'fileencoding', 'filetype' ],
      \   ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'CocStatus',
      \   'readonly': 'LightlineReadonly',
      \   'gitbranch': 'LightlineGitBranch',
      \   'path': 'LightlinePath'
      \ },
      \ 'component_expand': {
      \	  'hints': 'LightlineHints',
      \	  'warnings': 'LightlineWarnings',
      \	  'errors': 'LightlineErrors',
      \ },
      \ 'component_type': {
      \   'hints': 'info',
      \   'warnings': 'warning',
      \   'errors': 'error',
      \ }
      \ }

function! LightlineReadonly() abort
    return &readonly ? '' : ''
endfunction

function! LightlineGitBranch() abort
  if exists('*FugitiveHead')
    let branch = FugitiveHead()
    return branch !=# '' ? ' '.branch : ''
  endif
  return ''
endfunction

function! LightlinePath() abort
    return fnamemodify(expand('%:h'), ':~:.')
endfunction

function! AleCount(type) abort
  if !exists('g:ale_enabled') | return 0 | endif
  let l:bufnr = bufnr('%')
  let l:count = ale#statusline#Count(l:bufnr)
  if empty(l:count) | return 0 | endif
  return get(l:count, a:type, 0)
endfunction

function! CocStatus() abort
  return get(g:, 'coc_status', '')
endfunction

function! CocDiagnosticInfo(type) abort
  let l:info = get(b:, 'coc_diagnostic_info', {})
  if empty(l:info) | return 0 | endif
  return get(l:info, a:type, 0)
endfunction

function! LightlineHints() abort
  let l:count = AleCount('info') + CocDiagnosticInfo('hint') + CocDiagnosticInfo('information')
  return l:count > 0 ? l:count : ''
endfunction

function! LightlineWarnings() abort
  let l:count = AleCount('warning') + CocDiagnosticInfo('warning')
  return l:count > 0 ? l:count : ''
endfunction

function! LightlineErrors() abort
  let l:count = AleCount('error') + CocDiagnosticInfo('error')
  return l:count > 0 ? l:count : ''
endfunction

augroup lightline_update
  autocmd!
  autocmd User ALELintPost,CocStatusChange,CocDiagnosticChange call lightline#update()
augroup END
