" vim:fdm=marker

" Install Plugin Manager {{{
augroup vim_plug
  autocmd!
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
augroup END
" }}}

call plug#begin('~/.vim/plugged')

" Themes {{{
Plug 'altercation/vim-colors-solarized'
" }}}

" Statusbar {{{
Plug 'itchyny/lightline.vim'
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
function! LightlineReadonly() abort " {{{
    return &readonly ? '' : ''
endfunction " }}}
function! LightlineGitBranch() abort " {{{
  if exists('*fugitive#head')
    let branch = fugitive#head()
    return branch !=# '' ? ' '.branch : ''
  endif
  return ''
endfunction " }}}
function! LightlineAleCount() abort " {{{
  let l:bufnr = bufnr('%')
  return ale#statusline#Count(l:bufnr)
endfunction " }}}
function! LightlineAleWarning() abort " {{{
  let l:count = LightlineAleCount()
  return l:count.warning > 0 ? l:count.warning : ''
endfunction " }}}
function! LightlineAleError() abort " {{{
  let l:count = LightlineAleCount()
  return l:count.error > 0 ? l:count.error : ''
endfunction " }}}
function! LightlineGutentags() abort " {{{
  return gutentags#statusline()
endfunction " }}}
augroup lightline_update " {{{
  autocmd!
  autocmd User ALELintPOST call lightline#update()
  autocmd User GutentagsUpdating call lightline#update()
  autocmd User GutentagsUpdated call lightline#update()
augroup END " }}}
" }}}

" Text {{{
Plug 'inkarkat/vim-SpellCheck' " Populate spell check to quickfix.
Plug 'inkarkat/vim-ingo-library' " Dependency for vim-SpellCheck.
Plug 'junegunn/goyo.vim'
function! s:goyo_enter() abort " {{{
  setlocal formatoptions=t1
  setlocal smartindent
  setlocal spell
  setlocal spelllang=es_es
  setlocal noexpandtab
  setlocal wrap
  setlocal linebreak
  setlocal noshowmode
  setlocal noshowcmd
  setlocal scrolloff=999
endfunction " }}}

function! s:goyo_leave() abort " {{{
endfunction " }}}

augroup goyo_vim " {{{
  autocmd!
  au User GoyoEnter nested call <SID>goyo_enter()
  au User GoyoLeave nested call <SID>goyo_leave()
augroup END " }}}
" }}}

" Search {{{
Plug 'wsdjeg/FlyGrep.vim'
" }}}

" Syntax {{{
Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['markdown', 'latex']
" Javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_conceal_function             = 'ƒ'
let g:javascript_conceal_null                 = 'ø'
let g:javascript_conceal_this                 = '@'
let g:javascript_conceal_return               = '⇚'
let g:javascript_conceal_undefined            = '¿'
let g:javascript_conceal_NaN                  = 'ℕ'
let g:javascript_conceal_prototype            = '¶'
let g:javascript_conceal_static               = '•'
let g:javascript_conceal_super                = 'Ω'
let g:javascript_conceal_arrow_function       = '⇒'
let g:javascript_conceal_noarg_arrow_function = '🞅'
let g:javascript_conceal_underscore_arrow_function = '🞅'
" Clojure
let g:vimclojure#ParenRainbow = 1 " Enable rainbow parens
let g:vimclojure#DynamicHighlighting = 1 " Dynamic highlighting
let g:vimclojure#FuzzyIndent = 1 " Names beginning in 'def' or 'with' to be indented as if they were included in the 'lispwords' option
" Ruby
let g:ruby_operators = 1
let g:ruby_space_errors = 1
let g:ruby_fold = 1
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
let g:markdown_fenced_languages = ['ruby', 'html', 'javascript', 'css', 'erb=eruby.html', 'bash=sh', 'handlebars', 'json']
Plug 'joukevandermaas/vim-ember-hbs'
Plug 'chrisbra/vim-zsh', { 'for': 'zsh' }
Plug 'vim-scripts/bats.vim' " Bash Test Runner
" }}}

" File tree {{{
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
" }}}

" Comments {{{
Plug 'tpope/vim-commentary'
" }}}

" Misc {{{
Plug 'tpope/vim-repeat' " Repeat everything
Plug 'tpope/vim-abolish' " Camelcase, snakecase, mixedcase coercion
Plug 'tpope/vim-sleuth' " Autodetect indentation
Plug 'tpope/vim-unimpaired' " Pair aliases and toggling options
Plug 'mhinz/vim-startify' " Startup screen
let g:startify_change_to_dir = 0
Plug 'fcpg/vim-altscreen' " Clean terminal on vim shell commands
Plug 'mjbrownie/swapit' " <c-a> increments
Plug 'xtal8/traces.vim' " Search highlight as typing
Plug 'hauleth/sad.vim' " Change and repeat
nmap sn <Plug>(sad-change-forward)
nmap sp <Plug>(sad-change-backward)
Plug 'kopischke/vim-fetch' " Handle line number on filename
Plug 'vim-scripts/Spiffy-Foldtext' " Pretty folds
if has('multi_byte')
  let g:SpiffyFoldtext_format = '%c{ }  %<%f{ }═╡ %4n lines ╞═%l{ }'
else
  let g:SpiffyFoldtext_format = '%c{ }  %<%f{ }=| %4n lines |=%l{ }'
endif
Plug 'tmhedberg/matchit' " Extend % command
Plug 'ap/vim-css-color' " Hex colors highlight
Plug 'junegunn/vim-easy-align' " Align text
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
nmap <Leader>a <Plug>(EasyAlign)
Plug 'tpope/vim-dispatch' " Async shell commands
nnoremap <F9> :Dispatch<CR>
" }}}

" Git {{{
Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive' " Git commands
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Dispatch git commit<CR>
nnoremap <leader>ga :Gcommit --amend<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gw :Gwrite<CR><CR>
nnoremap <leader>gl :silent! Glog<CR>
nnoremap <leader>gp :Ggrep<Space>
nnoremap <leader>gm :Gmove<Space>
nnoremap <leader>gb :Git branch<Space>
nnoremap <leader>go :Git checkout<Space>
nnoremap <leader>gps :Dispatch git push<CR>
nnoremap <leader>gpl :Dispatch git pull<CR>
Plug 'airblade/vim-gitgutter' " Git gutter marks
Plug 'chrisbra/vim-diff-enhanced'
" started In Diff-Mode set diffexpr (plugin not loaded yet)
if &diff
    let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
endif
" }}}

" Notes {{{
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
let g:notes_directories = ['~/Dropbox/Notes']
" }}}

" Spaces / Tabs {{{
Plug 'editorconfig/editorconfig-vim', { 'do': 'brew install editorconfig' }
let g:EditorConfig_exclude_patterns = ['fugitive://.*']
Plug 'ntpeters/vim-better-whitespace'
augroup betterwhitespace_config " {{{
  autocmd!
  au BufWritePre * StripWhitespace
augroup END " }}}
" }}}

" LSP {{{
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
" Needs:
"  - npm install -g javascript-typescript-langserver
"  - pip3 install python-language-server
" Keybindings.
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
" Config.
let g:LanguageClient_diagnosticsList = 'Location'
let g:LanguageClient_serverCommands = {
      \ 'javascript': ['javascript-typescript-stdio'],
      \ 'python': ['pyls'],
      \ }
" }}}

" Autocompletion {{{
if v:version > 800 && has('python3')
  Plug 'Shougo/deoplete.nvim', { 'do': 'pip3 install neovim' } " Surround wrappers
  Plug 'roxma/nvim-yarp' " deoplete dependency.
  Plug 'roxma/vim-hug-neovim-rpc' " deoplete dependency
  Plug 'Shougo/neco-syntax' " syntax source
  Plug 'Shougo/neco-vim' " vim source
  Plug 'ujihisa/neco-look' " words source
  Plug 'wellle/tmux-complete.vim' " tmux panel source
  Plug 'fszymanski/deoplete-emoji' " emoji source
  Plug 'Shougo/context_filetype.vim' " code fences source
  " Configuration.
  set shortmess+=c " Remove messages for deoplete completion (match x of y)
  set completeopt+=noinsert
  " Plugin configuration.
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#enable_yarp = 1
  " Runtime configuration.
  augroup deoplete_vim
    autocmd!
    au VimEnter * call deoplete#custom#option({
          \ 'on_insert_enter': v:false,
          \ 'max_list': 10,
          \ })
    au VimEnter * call deoplete#custom#var('omni', 'input_patterns', {
	  \ 'tex': 'g:vimtex#re#deoplete'
	  \ })
  augroup END
  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"
  " <TAB>: completion.
  inoremap <expr><TAB> pumvisible() ? "\<C-y>" : "\<TAB>"
  " <C-j><C-k> aliases.
  inoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
  inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
endif
" }}}

" Parens, Brackets, etc... {{{
Plug 'jiangmiao/auto-pairs'
let g:AutoPairsFlyMode = 0
let g:AutoPairsMultilineClose = 0
let g:AutoPairsShortcutBackInsert = '<c-b>'
Plug 'machakann/vim-sandwich' " Surround wrappers
" }}}

" Snippets {{{
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'
Plug 'jjasghar/snipmate-snippets'
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-s>     <Plug>(neosnippet_expand_or_jump)
smap <C-s>     <Plug>(neosnippet_expand_or_jump)
xmap <C-s>     <Plug>(neosnippet_expand_target)
" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-s>     <Plug>(neosnippet_expand_or_jump)
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#enable_completed_snippet = 1
" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory=[
            \ '~/.vim/plugged/vim-snippets/snippets',
            \ '~/.vim/plugged/neosnippet-snippets/neosnippets',
            \ '~/.vim/snippets',
            \ '~/.vim/my-snippets',
            \ ]
" }}}

" Linter {{{
Plug 'w0rp/ale'
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
" }}}

" Scratchpad {{{
Plug 'metakirby5/codi.vim'
" }}}

" Navigation {{{
Plug 'christoomey/vim-tmux-navigator'
Plug 'terryma/vim-smooth-scroll'
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim', { 'do': 'brew install ripgrep' }
" Config.
let g:fzf_layout = { 'up': '~40%' }
let g:fzf_history_dir = '~/.local/share/fzf-history'
" Enable for MacOS
set rtp+=/usr/local/opt/fzf
" Mappings.
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> gb :Buffers<CR>
nnoremap gp :e %:h
" Commands.
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --hidden --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)
command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
" }}}

" Latex {{{
Plug 'lervag/vimtex'
let g:vimtex_quickfix_open_on_warning=0 " Dont open qf on warnins.
" Configure Skim as viewer.
let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r @line @pdf @tex'
" Folds.
let g:vimtex_fold_enabled = 1
" Update Skim after compilation.
let g:vimtex_compiler_callback_hooks = ['UpdateSkim']
function! UpdateSkim(status) abort " {{{
	if !a:status | return | endif
	let l:out = b:vimtex.out()
	let l:tex = expand('%:p')
	let l:cmd = [g:vimtex_view_general_viewer, '-r']
	if !empty(system('pgrep Skim'))
		call extend(l:cmd, ['-g'])
	endif
	if has('nvim')
		call jobstart(l:cmd + [line('.'), l:out, l:tex])
	elseif has('job')
		call job_start(l:cmd + [line('.'), l:out, l:tex])
	else
		call system(join(l:cmd + [line('.'), shellescape(l:out), shellescape(l:tex)], ' '))
	endif
endfunction " }}}
augroup vim_tex " {{{
  autocmd!
  au BufRead,BufNewFile *.tex setfiletype tex
augroup END " }}}
" }}}

" Thesaurus {{{
Plug 'beloglazov/vim-online-thesaurus'
" }}}

" Tags {{{
Plug 'majutsushi/tagbar'
if v:version >= 800
    Plug 'ludovicchabant/vim-gutentags'
endif
" }}}

" Markdown {{{
Plug 'dhruvasagar/vim-table-mode'
let g:table_mode_map_prefix = '<Leader>f'
let g:table_mode_corner = '|'
Plug 'JamshedVesuna/vim-markdown-preview' " Compilation
let g:vim_markdown_preview_hotkey = '<leader>m'
let vim_markdown_preview_pandoc=1
" }}}

" Marks {{{
Plug 'kshenoy/vim-signature' " Show marks
" }}}

" Help {{{
Plug 'chrisbra/vim_faq'
" }}}

" Language Tools {{{
Plug 'moll/vim-node' " Node
Plug 'racer-rust/vim-racer' " Rust
let g:racer_cmd = '$HOME/.cargo/bin/racer'
let g:racer_experimental_completer = 1
Plug 'Quramy/tsuquyomi' " Typescript server
" let g:tsuquyomi_disable_default_mappings = 1
Plug 'sukima/vim-ember-imports' " Ember Imports
Plug 'wannesm/wmgraphviz.vim' " Graphviz plugin
" }}}

call plug#end()
