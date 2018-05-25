" vim:fdm=marker

" Install plug.vim {{{
augroup vim_plug
  autocmd!
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
augroup END
" }}}

" Plugins START {{{
call plug#begin('~/.vim/plugged')
" }}}

" CSS Colors {{{
Plug 'ap/vim-css-color'
" }}}

" Lightline {{{
Plug 'itchyny/lightline.vim'
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ }
" }}}

" EasyAlign {{{
Plug 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
nmap <Leader>a <Plug>(EasyAlign)
" }}}

" Goyo {{{
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

Plug 'mustache/vim-mustache-handlebars'
" Plug 'nathanaelkane/vim-indent-guides'
" Plug 'oplatek/Conque-Shell'
Plug 'pangloss/vim-javascript'
" Plug 'rking/ag.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'Xuyuanp/nerdtree-git-plugin'
" Plug 'scrooloose/syntastic'
" Plug 'slim-template/vim-slim', { 'for': 'slim' }
" Plug 'thoughtbot/vim-rspec'
" Plug 'tpope/vim-haml'
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
" Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
" Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish' " Camelcase, snakecase, mixedcase coercion
Plug 'tpope/vim-sleuth' " Autodetect indentation
Plug 'tpope/vim-git'
Plug 'tpope/vim-unimpaired' " Pair aliases and toggling options
Plug 'tpope/vim-fugitive' " Git commands
" Plug 'vim-ruby/vim-ruby'
" Plug 'vim-scripts/fish.vim',   { 'for': 'fish' }
" Plug 'vim-scripts/jade.vim',   { 'for': 'jade' }
" Plug 'wavded/vim-stylus',      { 'for': 'stylus' }
" Plug 'wlangstroth/vim-racket'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
Plug 'editorconfig/editorconfig-vim', { 'do': 'brew install editorconfig' }
" Plug 'MarcWeber/vim-addon-mw-utils'
" Plug 'tomtom/tlib_vim'
" Plug 'SirVer/ultisnips'
Plug 'Shougo/vimproc.vim', { 'do' : 'make' }
" Plug 'Shougo/neocomplete.vim'
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }

" Deoplete {{{
if v:version > 800 && has('python3')
  Plug 'Shougo/deoplete.nvim', { 'do': 'pip3 install neovim' } " Surround wrappers
  Plug 'roxma/nvim-yarp' " deoplete dependency.
  Plug 'roxma/vim-hug-neovim-rpc' " deoplete dependency

  let g:deoplete#enable_at_startup = 1
  let g:deoplete#enable_yarp = 1

  augroup deoplete_vim
    autocmd!
    au VimEnter * call deoplete#custom#option({
          \ 'auto_complete_delay': 100,
          \ 'max_list': 10,
          \ })
  augroup END

  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"

  " <TAB>: completion.
  inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
endif
" }}}

" Jedi {{{
if g:deoplete#enable_at_startup
  Plug 'zchee/deoplete-jedi' " Python Completion (deoplete)
endif
" }}}

" Plug 'wokalski/autocomplete-flow' " Javascript Completion (deoplete)
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neco-syntax'
Plug 'Shougo/neopairs.vim'
Plug 'honza/vim-snippets'
Plug 'jjasghar/snipmate-snippets'
" Plug 'danro/rename.vim'
" Plug 'mileszs/ack.vim'
" Plug 'severin-lemaignan/vim-minimap'
" Plug 'junegunn/vim-peekaboo'
" Plug 'justinmk/vim-sneak'
" Plug 'easymotion/vim-easymotion'
" Plug 'haya14busa/incsearch.vim'
" Plug 'haya14busa/incsearch-easymotion.vim'
" Plug 'haya14busa/incsearch-fuzzy.vim'
" Plug 'PeterRincker/vim-argumentative'
Plug 'Olical/vim-enmasse' " Quickfix changes
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' }
Plug 'elzr/vim-json'
" Plug 'rickhowe/diffchar.vim'
Plug 'tpope/vim-dispatch'
" Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'jiangmiao/auto-pairs'
" Plug 'kshenoy/vim-signature'
Plug 'christoomey/vim-tmux-navigator'
Plug 'airblade/vim-gitgutter'
Plug 'ntpeters/vim-better-whitespace'
" Plug 'Chiel92/vim-autoformat'
" Plug 'terryma/vim-multiple-cursors'
Plug 'w0rp/ale'
" Plug 'mbbill/undotree'
Plug 'altercation/vim-colors-solarized'
Plug 'joukevandermaas/vim-ember-hbs'
" Plug 'andrewradev/ember_tools.vim'
Plug 'alexlafroscia/vim-ember-cli'
" Plug 'alexbyk/vim-ultisnips-js-testing'
" Plug 'vim-airline/vim-airline-themes'
" Plug 'francoiscabrol/ranger.vim'
Plug 'dhruvasagar/vim-table-mode'
" Plug 'terryma/vim-expand-region'
" Plug 'jebaum/vim-tmuxify'
" Plug 'yuttie/comfortable-motion.vim'
Plug 'terryma/vim-smooth-scroll'
Plug 'mhinz/vim-startify'
" Plug 'ervandew/supertab'
Plug 'chrisbra/vim-diff-enhanced'
Plug 'fcpg/vim-altscreen'
Plug 'mjbrownie/swapit' " <c-a> increments
Plug 'chrisbra/vim-zsh', { 'for': 'zsh' }
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'lervag/vimtex'
" Plug 'brennier/quicktex'
Plug 'beloglazov/vim-online-thesaurus'
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
" Plug 't9md/vim-quickhl'
" Plug 'dsawardekar/portkey'
" Plug 'dsawardekar/ember.vim'
" Plug 'nixon/vim-vmath'
" Plug 'tpope/vim-vinegar'
Plug 'majutsushi/tagbar'
" Plug 'matze/vim-move'
Plug 'euclio/vim-markdown-composer', { 'for' : 'markdown', 'do': function('BuildComposer') }
Plug 'digitaltoad/vim-pug'
Plug 'kshenoy/vim-signature' " Show marks
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim', { 'do': 'brew install ripgrep' }
" Plug 'esalter-va/vim-checklist'
Plug 'cespare/vim-toml'
" Plug 'mboughaba/i3config.vim'
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
Plug 'xtal8/traces.vim'
Plug 'chrisbra/vim_faq'
Plug 'hauleth/sad.vim' " Change and repeat
Plug 'machakann/vim-sandwich' " Surround wrappers
Plug 'moll/vim-node'
Plug 'kopischke/vim-fetch'
if v:version >= 800 && executable('ctags')
    Plug 'ludovicchabant/vim-gutentags'
endif
Plug 'vim-scripts/Spiffy-Foldtext'
Plug 'tmhedberg/matchit'
Plug 'vim-scripts/bats.vim' " Bash Test Runner
Plug 'leafgarland/typescript-vim' " Typescript syntax
Plug 'Quramy/tsuquyomi' " Typescript server
Plug 'sukima/vim-ember-imports'


" Plugins END {{{
call plug#end()
" }}}
