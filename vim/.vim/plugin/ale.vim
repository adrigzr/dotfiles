let g:ale_sign_column_always = 1
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
let g:ale_linters = {
      \ 'tex': ['chktex'],
      \ 'javascript': ['eslint'],
      \ 'python': ['pylint'],
      \ 'rust': ['rls'],
      \ 'zsh': ['shellcheck'],
      \ }
