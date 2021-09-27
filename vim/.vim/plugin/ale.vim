let g:ale_lint_delay = 1000
let g:ale_virtualtext_cursor = 1
let g:ale_virtualtext_prefix = '▸ '
let g:ale_sign_column_always = 1
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
let g:ale_linters = {
      \ 'tex': ['chktex'],
      \ 'javascript': [],
      \ 'typescript': [],
      \ 'python': ['pylint'],
      \ 'rust': ['rls'],
      \ 'zsh': ['shellcheck'],
      \ }
let g:ale_fix_on_save = 1
let g:ale_fixers = {
      \ 'html': [],
      \ 'javascript': [],
      \ 'typescript': []
      \ }
