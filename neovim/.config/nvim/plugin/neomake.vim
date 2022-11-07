let g:neomake_enabled_makers = ['tsc', 'eslint']
let g:neomake_eslint_maker = neomake#makers#ft#javascript#eslint()
let g:neomake_eslint_maker.cwd = ''
let g:neomake_eslint_maker.args = ['--format=json', '--cache', '.']
