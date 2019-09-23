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
" }}}

" Text {{{
Plug 'inkarkat/vim-SpellCheck' " Populate spell check to quickfix.
Plug 'inkarkat/vim-ingo-library' " Dependency for vim-SpellCheck.
" Plug 'junegunn/goyo.vim'
" }}}

" Search {{{
" Plug 'wsdjeg/FlyGrep.vim'
" }}}

" Syntax {{{
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'joukevandermaas/vim-ember-hbs'
Plug 'chrisbra/vim-zsh', { 'for': 'zsh' }
Plug 'vim-scripts/bats.vim' " Bash Test Runner
" }}}

" File tree {{{
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeFind' }
" Plug 'Xuyuanp/nerdtree-git-plugin'
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
" Plug 'fcpg/vim-altscreen' " Clean terminal on vim shell commands
Plug 'mjbrownie/swapit' " <c-a> increments
Plug 'xtal8/traces.vim' " Search highlight as typing
Plug 'hauleth/sad.vim' " Change and repeat
Plug 'kopischke/vim-fetch' " Handle line number on filename
Plug 'vim-scripts/Spiffy-Foldtext' " Pretty folds
Plug 'tmhedberg/matchit' " Extend % command
" Plug 'ap/vim-css-color' " Hex colors highlight
Plug 'junegunn/vim-easy-align' " Align text
Plug 'tpope/vim-dispatch' " Async shell commands
" }}}

" Git {{{
Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive' " Git commands
Plug 'airblade/vim-gitgutter' " Git gutter marks
" Plug 'chrisbra/vim-diff-enhanced'
" " started In Diff-Mode set diffexpr (plugin not loaded yet)
" if &diff
"     let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
" endif
" }}}

" Notes {{{
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
" }}}

" Spaces / Tabs {{{
Plug 'editorconfig/editorconfig-vim', { 'do': 'brew install editorconfig' }
Plug 'ntpeters/vim-better-whitespace'
" }}}

" LSP {{{
" Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
" }}}

" Autocompletion {{{
" if v:version > 800 && has('python3')
"   Plug 'Shougo/deoplete.nvim', { 'do': 'pip3 install neovim' } " Surround wrappers
"   Plug 'roxma/nvim-yarp' " deoplete dependency.
"   Plug 'roxma/vim-hug-neovim-rpc' " deoplete dependency
"   Plug 'Shougo/neco-syntax' " syntax source
"   Plug 'Shougo/neco-vim' " vim source
"   Plug 'ujihisa/neco-look' " words source
"   Plug 'wellle/tmux-complete.vim' " tmux panel source
"   Plug 'fszymanski/deoplete-emoji' " emoji source
"   Plug 'Shougo/context_filetype.vim' " code fences source
" endif
Plug 'Shougo/neco-syntax' " vim syntax source
Plug 'neoclide/coc-neco'
Plug 'neoclide/coc.nvim', {'tag': '*' }
" }}}

" Parens, Brackets, etc... {{{
Plug 'jiangmiao/auto-pairs'
Plug 'machakann/vim-sandwich' " Surround wrappers
" }}}

" Snippets {{{
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'
Plug 'jjasghar/snipmate-snippets'
" }}}

" Linter {{{
Plug 'w0rp/ale'
" }}}

" Scratchpad {{{
" Plug 'metakirby5/codi.vim'
" }}}

" Navigation {{{
Plug 'christoomey/vim-tmux-navigator'
Plug 'terryma/vim-smooth-scroll'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim', { 'do': 'brew install ripgrep' }
if v:version >= 800 && has('python3')
  if !has('nvim')
    Plug 'roxma/nvim-yarp' " denite dependency.
    Plug 'roxma/vim-hug-neovim-rpc' " denite dependency
  endif
  " Plug 'Shougo/denite.nvim', { 'do': 'pip3 install pynvim' }
endif
" }}}

" Latex {{{
Plug 'lervag/vimtex'
" }}}

" Thesaurus {{{
" Plug 'beloglazov/vim-online-thesaurus'
" }}}

" Tags {{{
" Plug 'majutsushi/tagbar'
" if v:version >= 800
    " Plug 'ludovicchabant/vim-gutentags'
" endif
" }}}

" Markdown {{{
Plug 'dhruvasagar/vim-table-mode', { 'for': 'markdown' }
Plug 'JamshedVesuna/vim-markdown-preview', { 'for': 'markdown' } " Compilation
" }}}

" Marks {{{
Plug 'kshenoy/vim-signature' " Show marks
" }}}

" Help {{{
Plug 'chrisbra/vim_faq'
" }}}

" Debugging {{{
Plug 'tpope/vim-scriptease'
" }}}

" Language Tools {{{
Plug 'moll/vim-node' " Node
Plug 'racer-rust/vim-racer' " Rust
" Plug 'Quramy/tsuquyomi' " Typescript server
" let g:tsuquyomi_disable_default_mappings = 1
Plug 'sukima/vim-javascript-imports'
Plug 'sukima/vim-ember-imports' " Ember Imports
Plug 'wannesm/wmgraphviz.vim' " Graphviz plugin
Plug 'junegunn/vader.vim' " Vim script tester
if has('nvim')
  Plug 'meain/vim-package-info', { 'do': 'npm install -g neovim && npm install' } " View the latest version of packages
endif
Plug 'mattn/emmet-vim'
Plug 'posva/vim-vue'
" }}}

call plug#end()
