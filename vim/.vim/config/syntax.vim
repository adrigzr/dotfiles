
" Type assign -------------------------------------------------------------

augroup filetype_fish " {{{
  autocmd!
  au BufRead,BufNewFile *.fish  setfiletype fish
augroup END " }}}

augroup filetype_hbs " {{{
  autocmd!
  au BufRead,BufNewFile *.handlebars,*.hbs.erb,*.handlebars.erb setfiletype mustache
augroup END " }}}

augroup filetype_jade " {{{
  autocmd!
  au BufRead,BufNewFile *.jade setfiletype jade
augroup END " }}}

augroup filetype_nu " {{{
  autocmd!
  au BufRead,BufNewFile *.nu,*.nujson,Nukefile setfiletype nu
augroup END " }}}

augroup filetype_ruby " {{{
  autocmd!
  au BufRead,BufNewFile Rakefile,Capfile,Gemfile,.autotest,.irbrc,*.treetop,*.tt setfiletype ruby
augroup END " }}}

augroup filetype_csv " {{{
  autocmd!
  au BufRead,BufNewFile *.csv,*.dat setfiletype csv
augroup END " }}}

augroup filetype_zsh " {{{
  autocmd!
  au BufRead,BufNewFile .zsh_rc,.functions,.commonrc setfiletype zsh
augroup END " }}}

" Type settings -------------------------------------------------------------

augroup filetype_coffee " {{{
  autocmd!
  au FileType coffee setlocal foldmethod=indent
augroup END " }}}

augroup filetype_json " {{{
  autocmd!
  au FileType json setlocal equalprg=python\ -m\ json.tool
augroup END " }}}

augroup filetype_bash " {{{
  autocmd!
  au FileType sh setlocal formatprg=shfmt\ -bn\ -ci
augroup END " }}}

augroup filetype_markdown " {{{
  autocmd!
  au FileType markdown set wrap
augroup END " }}}

augroup filetype_bats " {{{
  autocmd!
  au BufNewFile,BufReadPost *.bats exe ":ALEDisableBuffer"
augroup END " }}}

augroup filetype_dot " {{{
  autocmd!
  au FileType dot setlocal makeprg=dot\ -Tpng\ \"%:p\"\ -o\ \"%:p:r.png\"
augroup END " }}}
