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
" Plug 'altercation/vim-colors-solarized'
" Plug 'tomasiser/vim-code-dark'
" Plug 'haishanh/night-owl.vim'
" Plug 'flrnprz/plastic.vim'
" Plug 'joshdick/onedark.vim', { 'branch': 'main' }
Plug 'navarasu/onedark.nvim'
" }}}

" Icons {{{
Plug 'kyazdani42/nvim-web-devicons'
" }}}

" Statusbar {{{
" Plug 'itchyny/lightline.vim'
Plug 'hoob3rt/lualine.nvim'
" }}}

" Text {{{
" Plug 'inkarkat/vim-SpellCheck' " Populate spell check to quickfix.
" Plug 'inkarkat/vim-ingo-library' " Dependency for vim-SpellCheck.
" Plug 'junegunn/goyo.vim'
" }}}

" Search {{{
" Plug 'wsdjeg/FlyGrep.vim'
Plug 'windwp/nvim-spectre' " Classic Search & Replace
Plug 'kevinhwang91/nvim-hlslens' " Search Helper
Plug 'xtal8/traces.vim' " Replace highlight as typing
Plug 'ggandor/lightspeed.nvim' " Quick search motions
" }}}

" Syntax {{{
" Plug 'sheerun/vim-polyglot' " Disabled for nvim-treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'joukevandermaas/vim-ember-hbs' " Disabled for nvim-treesitter
Plug 'chrisbra/vim-zsh', { 'for': 'zsh' }
Plug 'vim-scripts/bats.vim' " Bash Test Runner
Plug 'pantharshit00/vim-prisma'
" }}}

" File tree {{{
" Plug 'antoinemadec/FixCursorHold.nvim' " Fixes issues in neovim
" Plug 'lambdalisue/nerdfont.vim'
" Plug 'lambdalisue/glyph-palette.vim'
" Plug 'lambdalisue/fern.vim' " Tree plugin
" Plug 'lambdalisue/fern-renderer-nerdfont.vim' " Add icons to tree
" Plug 'lambdalisue/fern-mapping-project-top.vim' " Add mappings to tree
" Plug 'scrooloose/nerdtree'
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " Works with vim-devicons
" Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'kyazdani42/nvim-tree.lua'
" }}}

" Comments {{{
Plug 'tpope/vim-commentary'
" }}}

" Misc {{{
Plug 'tpope/vim-repeat' " Repeat everything
Plug 'tpope/vim-abolish' " Camelcase, snakecase, mixedcase coercion
" Plug 'tpope/vim-sleuth' " Autodetect indentation
Plug 'tpope/vim-unimpaired' " Pair aliases and toggling options
" Plug 'fcpg/vim-altscreen' " Clean terminal on vim shell commands
Plug 'mjbrownie/swapit' " <c-a> increments
Plug 'hauleth/sad.vim' " Change and repeat
Plug 'kopischke/vim-fetch' " Handle line number on filename
Plug 'vim-scripts/Spiffy-Foldtext' " Pretty folds
Plug 'tmhedberg/matchit' " Extend % command
" Plug 'ap/vim-css-color' " Hex colors highlight
" Plug 'junegunn/vim-easy-align' " Align text
Plug 'tpope/vim-dispatch' " Async shell commands
Plug 'norcalli/nvim-colorizer.lua'
" Plug 'romgrk/barbar.nvim' " Tab bar line
Plug 'moll/vim-bbye' " BufferClose commands
Plug 'github/copilot.vim' " Github copilot
Plug 'lukas-reineke/indent-blankline.nvim' " Indentation guides
Plug 'lewis6991/impatient.nvim' " Speedup nvim
" }}}

" Start screen {{{
" Plug 'mhinz/vim-startify' " Startup screen
Plug 'glepnir/dashboard-nvim'
" }}}

" Git {{{
" Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive' " Git commands
" Plug 'stsewd/fzf-checkout.vim'
" Plug 'airblade/vim-gitgutter' " Git gutter marks
Plug 'lewis6991/gitsigns.nvim'
" Plug 'chrisbra/vim-diff-enhanced'
" " started In Diff-Mode set diffexpr (plugin not loaded yet)
" if &diff
"     let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
" endif
Plug 'rhysd/conflict-marker.vim' " Mappings for conflicts
Plug 'sindrets/diffview.nvim' " Diff view
" }}}

" Notes {{{
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
" }}}

" Spaces / Tabs {{{
Plug 'editorconfig/editorconfig-vim'
Plug 'ntpeters/vim-better-whitespace'
" }}}

" LSP {{{
" Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'folke/trouble.nvim' " Pretty diagnostics
Plug 'filipdutescu/renamer.nvim', { 'branch': 'master' }
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
" Plug 'Shougo/neco-syntax' " vim syntax source
" Plug 'neoclide/coc-neco'
" Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'npm install -g yarn && yarn install --frozen-lockfile'}
" Plug 'antoinemadec/coc-fzf'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/nvim-cmp'
Plug 'onsails/lspkind-nvim' " Pretty completion items
" }}}

" Snippets {{{
" Plug 'Shougo/neosnippet'
" Plug 'Shougo/neosnippet-snippets'
" Plug 'honza/vim-snippets'
" Plug 'jjasghar/snipmate-snippets'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'rafamadriz/friendly-snippets'
" }}}


" Parens, Brackets, etc... {{{
" Plug 'jiangmiao/auto-pairs'
" Plug 'machakann/vim-sandwich' " Surround wrappers
Plug 'tpope/vim-surround' " Surround wrappers
Plug 'p00f/nvim-ts-rainbow' " Colorize parens
Plug 'windwp/nvim-autopairs' " Auto-pairs
" }}}

" Linter {{{
" Plug 'dense-analysis/ale'
" }}}

" Scratchpad {{{
" Plug 'metakirby5/codi.vim'
" }}}

" Navigation {{{
Plug 'christoomey/vim-tmux-navigator'
Plug 'nvim-lua/plenary.nvim' " Lua helpers
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' } " FZF for telescope
" Plug 'fannheyward/telescope-coc.nvim' " CoC for telescope
Plug 'nvim-telescope/telescope.nvim' " Fuzzy Finder
" Plug 'terryma/vim-smooth-scroll'
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug 'junegunn/fzf.vim', { 'do': 'brew install ripgrep && brew install bat' }
" if v:version >= 800 && has('python3')
"   if !has('nvim')
"     Plug 'roxma/nvim-yarp' " denite dependency.
"     Plug 'roxma/vim-hug-neovim-rpc' " denite dependency
"   endif
"   " Plug 'Shougo/denite.nvim', { 'do': 'pip3 install pynvim' }
" endif
" }}}

" Latex {{{
" Plug 'lervag/vimtex'
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
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
" }}}

" Marks {{{
" Plug 'kshenoy/vim-signature' " Show marks
" }}}

" Help {{{
" Plug 'chrisbra/vim_faq'
" }}}

" Debugging {{{
Plug 'tpope/vim-scriptease'
" }}}

" Helpers {{{
Plug 'folke/which-key.nvim'
" }}}

" Language Tools {{{
Plug 'moll/vim-node' " Node
" Plug 'racer-rust/vim-racer' " Rust
" Plug 'Quramy/tsuquyomi' " Typescript server
" let g:tsuquyomi_disable_default_mappings = 1
Plug 'sukima/vim-javascript-imports'
Plug 'sukima/vim-ember-imports' " Ember Imports
Plug 'wannesm/wmgraphviz.vim' " Graphviz plugin
Plug 'junegunn/vader.vim' " Vim script tester
" if has('nvim')
  " Plug 'meain/vim-package-info', { 'do': 'npm install -g neovim && npm install' } " View the latest version of packages
" endif
" Plug 'mattn/emmet-vim'
Plug 'posva/vim-vue'
Plug 'Quramy/vim-js-pretty-template'
" }}}

call plug#end()
