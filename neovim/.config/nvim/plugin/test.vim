scriptencoding utf-8

" vim-test
let test#strategy = 'neovim'
let test#neovim#term_position = 'vert'
let test#javascript#mocha#options = '--reporter tap'
let test#javascript#mocha#file_pattern = '\v(tests?/.*|(test))\.(js|ts|jsx|tsx|coffee)$'
let test#javascript#jest#file_pattern = '\v((__tests?__|tests?)/.*|(spec|test|steps))\.(js|jsx|coffee|ts|tsx)$'

" vim-ultest
let ultest_use_pty = 1
let ultest_pass_sign = ''
let ultest_fail_sign = ''
let ultest_running_sign = ''
let ultest_not_run_sign = ''

highlight def link UltestFail DiagnosticError
highlight def link UltestRunning DiagnosticInfo
