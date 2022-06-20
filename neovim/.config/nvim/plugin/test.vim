scriptencoding utf-8

function! CustomAsyncRun(cmd) abort
  let g:test#strategy#cmd = a:cmd
  call test#strategy#asyncrun_setup_unlet_global_autocmd()
  execute 'AsyncRun -mode=async -silent -strip -post=echo\ eval("g:asyncrun_code\ ?\"Failure\":\"Success\"").":"\ substitute(g:test\#strategy\#cmd,\ "\\",\ "",\ "") '.a:cmd
endfunction

function! JestTransform(cmd) abort
  let l:current_folder = expand('%:p:h')
  let l:root_folder = luaeval('require("lspconfig").util.root_pattern("jest.config.js")("'.l:current_folder.'")')
  let l:cmd = substitute(a:cmd, '#TOKEN#', '--config="'.l:root_folder.'/jest.config.js"', '')
  echom l:cmd
  return l:cmd
endfunction

" vim-test
let test#strategy = 'custom_asyncrun'
let test#custom_strategies = {
      \ 'custom_asyncrun': function('CustomAsyncRun'),
      \ }
let test#custom_transformations = {
      \ 'jest': function('JestTransform'),
      \ }
let test#transformation = 'jest'
let test#neovim#term_position = 'vert'
let test#javascript#mocha#options = '--reporter tap'
let test#javascript#mocha#file_pattern = '\v(tests?/.*|(test))\.(js|ts|jsx|tsx|coffee)$'
let test#javascript#jest#file_pattern = '\v((__tests?__|tests?)/.*|(spec|test|steps))\.(js|jsx|coffee|ts|tsx)$'
let test#javascript#jest#options = '--reporters jest-vim-reporter --no-coverage #TOKEN#'

" vim-ultest
let ultest_deprecation_notice = 0
let ultest_use_pty = 1
let ultest_pass_sign = ''
let ultest_fail_sign = ''
let ultest_running_sign = ''
let ultest_not_run_sign = ''

highlight def link UltestFail DiagnosticError
highlight def link UltestRunning DiagnosticInfo

nnoremap <leader>uu <cmd>Ultest<cr>
nnoremap <leader>uo <cmd>UltestSummaryOpen<cr>
nnoremap <leader>uq <cmd>UltestSummaryClose<cr>

augroup TestConfig
    autocmd!
    " autocmd BufWritePost * if test#exists() | TestFile | endif
    autocmd User AsyncRunStop if get(g:, 'asyncrun_code') | execute 'Trouble quickfix' | endif
augroup END

" augroup UltestRunner
"     autocmd!
"     autocmd BufWritePost * Ultest
" augroup END
