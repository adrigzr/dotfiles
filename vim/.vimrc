" vim:fdm=marker

" Settings -------------------------------------------------------------

" Preamble {{{

" Syntax highlighting {{{
if !exists('g:syntax_on')
  syntax enable
endif
set t_Co=256 " Terminal colors.
set background=dark
set encoding=utf-8 nobomb " BOM often causes trouble
scriptencoding utf-8
" }}}

" Mapleader {{{
let g:mapleader="\<Space>"
" }}}

" Local directories {{{
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
set undodir=~/.vim/undo
" }}}

" Set some junk {{{
set autoindent " Copy indent from last line when starting new line
set backspace=indent,eol,start
set cursorline " Highlight current line
set diffopt=filler " Add vertical spaces to keep right and left aligned
set diffopt+=iwhite " Ignore whitespace changes (focus on code changes)
set diffopt+=internal " Use the internal diff library
set diffopt+=indent-heuristic " Use the indent heuristic
set diffopt+=algorithm:patience " Use patience diff algorithm
set esckeys " Allow cursor keys in insert mode
" set expandtab " Expand tabs to spaces
set foldenable " Enable folding
set foldcolumn=0 " Column to show folds
set foldlevel=0 " Close all folds by default
set foldlevelstart=-1 " Start fold level
set foldmethod=syntax " Syntax are used to specify folds
set foldminlines=0 " Allow folding single lines
set foldnestmax=10 " Set max fold nesting level
set foldclose="" Close as you walk out a fold
" set nofoldenable " Disable fold.
set formatoptions=
set formatoptions+=c " Format comments
set formatoptions+=r " Continue comments by default
set formatoptions+=o " Make comment when using o or O from comment line
set formatoptions+=q " Format comments with gq
set formatoptions+=n " Recognize numbered lists
set formatoptions+=2 " Use indent from 2nd line of a paragraph
set formatoptions+=l " Don't break lines that are already long
set formatoptions+=1 " Break before 1-letter words
set formatoptions+=j " Join comments without leader.
set gdefault " By default add g flag to search/replace. Add g to toggle
set hidden " When a buffer is brought to foreground, remember undo history and marks
set history=1000 " Increase history from 20 default to 1000
set hlsearch " Highlight searches
set ignorecase " Ignore case of searches
set incsearch " Highlight dynamically as pattern is typed
set laststatus=2 " Always show status line
set lazyredraw " Don't redraw when we don't have to
set lispwords+=defroutes " Compojure
set lispwords+=defpartial,defpage " Noir core
set lispwords+=defaction,deffilter,defview,defsection " Ciste core
set lispwords+=describe,it " Speclj TDD/BDD
set magic " Enable extended regexes
set mouse=a " Enable mouse in all modes
set noerrorbells " Disable error bells
set nojoinspaces " Only insert single space after a '.', '?' and '!' with a join command
set noshowmode " Don't show the current mode (statusline takes care of us)
set nostartofline " Don't reset cursor to start of line when moving around
set nowrap " Do not wrap lines
set number " Enable line numbers
set omnifunc=syntaxcomplete#Complete " Set omni-completion method
set regexpengine=1 " Use the old regular expression engine (it's faster for certain language syntaxes)
set report=0 " Show all changes
set ruler " Show the cursor position
set scrolloff=6 " Start scrolling three lines before horizontal border of window
set shell=/bin/sh " Use /bin/sh for executing shell commands
set shortmess=atI " Don't show the intro message when starting vim
set showtabline=1 " Show tab bar
set sidescrolloff=3 " Start scrolling three columns before vertical border of window
set smartcase " Ignore 'ignorecase' if search patter contains uppercase characters
set smarttab " At start of line, <Tab> inserts shiftwidth spaces, <Bs> deletes shiftwidth spaces
set softtabstop=2 " Tab key results in 2 spaces
set splitbelow " New window goes below
set splitright " New windows goes right
set suffixes=.bak,~,.swp,.swo,.o,.d,.info,.aux,.log,.dvi,.pdf,.bin,.bbl,.blg,.brf,.cb,.dmg,.exe,.ind,.idx,.ilg,.inx,.out,.toc,.pyc,.pyd,.dll
set switchbuf=""
set title " Show the filename in the window titlebar
set ttyfast " Send more characters at a given time
set ttymouse=xterm " Set mouse type to xterm
set undofile " Persistent Undo
set viminfo='9999,s512,n~/.vim/viminfo " Restore buffer list, marks are remembered for 9999 files, registers up to 512Kb are remembered
set visualbell " Use visual bell instead of audible bell (annnnnoying)
set browsedir=buffer " browse files in same dir as open file
set wildchar=<TAB> " Character for CLI expansion (TAB-completion)
set wildignore+=.DS_Store
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js
" set wildignore+=*/.git/logs/*,*/.git/refs/*
" set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
set wildignore+=*/smarty/*,*/.sass-cache/*,*/log/*,*/tmp/*,*/build/*,*/ckeditor/*,*/doc/*,*/source_maps/*,*/dist/*,*/recs/*
set wildmenu " Hitting TAB in command mode will show possible completions above command line
set wildmode=list:longest,full " Complete only until point of ambiguity
set wildignorecase
set winminheight=0 " Allow splits to be reduced to a single line
set wrapscan " Searches wrap around end of file
set shiftwidth=4 " Fix mixed-indent warning
set tags+=.tags/tags " Set tags folder.
set infercase " Improve ignorecase
set synmaxcol=400 " Enable syntax highlight on the first 200 cols
set breakindent " Preserve indentation on wrap toggle
set showbreak=⤷ " String to use on breakindent
" set autoread " Force check disk file
set timeout " enable timeout for mapping
set ttimeout " enable timeout for key codes
set ttimeoutlen=10 " unnoticeable small value
set cmdheight=1 " avoid hit-enter prompts
" set clipboard=autoselect
set listchars=tab:\¦\ ,trail:·,eol:¬,nbsp:_
set fillchars=fold:-
set relativenumber " Use relative line numbers. Current line is still in status bar.
set conceallevel=0 " No conceal
set timeoutlen=1000
" }}}

" }}}

" Configuration -------------------------------------------------------------

" FastEscape {{{
" Speed up transition from modes
if ! has('gui_running')
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif
" }}}

" Mappings {{{
source ~/.vim/config/mappings.vim
" }}}

" Create directory on save {{{
if !exists('*s:MkNonExDir')
  function s:MkNonExDir(file, buf) abort
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
      let l:dir=fnamemodify(a:file, ':h')
      if !isdirectory(l:dir)
        call mkdir(l:dir, 'p')
      endif
    endif
  endfunction
endif

augroup BWCCreateDir
    autocmd!
    au BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END
" }}}

" Jumping to tags {{{
augroup jump_to_tags
  autocmd!
  " Pulse Line (thanks Steve Losh)
  function! s:Pulse() abort " {{{
    redir => l:old_hi
    silent execute 'hi CursorLine'
    redir END
    let l:old_hi = split(l:old_hi, "\n")[0]
    let l:old_hi = substitute(l:old_hi, 'xxx', '', '')

    let l:steps = 8
    let l:width = 1
    let l:start = l:width
    let l:end = l:steps * l:width
    let l:color = 233

    for l:i in range(l:start, l:end, l:width)
      execute 'hi CursorLine ctermbg=' . (l:color + l:i)
      redraw
      sleep 6m
    endfor
    for l:i in range(l:end, l:start, -1 * l:width)
      execute 'hi CursorLine ctermbg=' . (l:color + l:i)
      redraw
      sleep 6m
    endfor

    execute 'hi ' . l:old_hi
  endfunction " }}}

  command! -nargs=0 Pulse call s:Pulse()
augroup END
" }}}

" Colors {{{
augroup colors_config
  autocmd!
  " Transparent background {{{
  hi Normal guibg=NONE ctermbg=NONE
  hi NonText guibg=NONE ctermbg=NONE
  " }}}

  " Color (see listchars) {{{
  hi NonText ctermfg=10 ctermbg=8 guifg=#000000 guibg=#000000
  hi SpecialKey term=NONE cterm=NONE
  " }}}
augroup END
" }}}

" Restore Cursor Position {{{
augroup restore_cursor
  autocmd!
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
augroup END
" }}}

" Highlight Ugly Code {{{
augroup highlight_ugly_code
  autocmd!
  " match ErrorMsg '\s\+$' " Trailing spaces.
  " match ErrorMsg '\%>120v.\+' " Long lines of code.
augroup END
" }}}

" Automatically equalize splits when vim is resized {{{
augroup auto_resize
	autocmd!
	autocmd VimResized * wincmd =
augroup END
" }}}

" Custom commands {{{
augroup custom_commands
  autocmd!
  " Format json.
  command! -nargs=0 FormatJSON execute "%!python -m json.tool"

  " Copy current file path.
  command! -nargs=0 CopyPath execute "let @+ = expand('%')"
augroup END
" }}}

" Swap Cursors on mode change {{{
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
" }}}

" Relative numbers {{{
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
" }}}

" Text configuration {{{
augroup text_config
  autocmd!
  au FileType tex,markdown setlocal formatoptions=t1 wrap spell spelllang=es_es noexpandtab linebreak smartindent synmaxcol=3000 display=lastline
augroup END
" }}}

" Find {{{
augroup find_config
  autocmd!
  if executable('rg')
    " Note we extract the column as well as the file and line number
    set grepprg=rg\ --no-heading\ --vimgrep\ --smart-case\ --color=never\ --ignore-case\ --hidden
    set grepformat=%f:%l:%c:%m,%f:%l:%m

    " Make the command.
    command! -nargs=+ -complete=dir Find execute 'silent grep!' <q-args> | copen | redraw!
  endif
augroup END
" }}}

" IncSearch Highlight {{{
augroup incsearch_highlight_config
  autocmd!
  " Function.
  fu! s:toggle_hls(on_enter) abort
      if a:on_enter
          let s:hls_on = &hlsearch
          set hlsearch
      else
          if exists('s:hls_on')
              exe 'set '.(s:hls_on ? '' : 'no').'hls'
              unlet! s:hls_on
          endif
      endif
  endfu
  " Commands.
  if has('patch1206')
      autocmd CmdlineEnter [/\?] call s:toggle_hls(1)
      autocmd CmdlineLeave [/\?] call s:toggle_hls(0)
  endif
augroup END
" }}}

" vim_netrw.vim {{{
augroup vim_netrw
  autocmd!
  let g:netrw_browsex_viewer = 'xdg-open'
augroup END
" }}}

" Syntax {{{
source ~/.vim/config/syntax.vim
" }}}

" Load Plugins {{{
source ~/.vim/config/pluggins.vim
" }}}

" Color schemes {{{
colorscheme solarized
" }}}

