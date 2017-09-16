" vim:fdm=marker

" Settings -------------------------------------------------------------

" Preamble {{{

" Make vim more useful {{{
set nocompatible
" }}}

" Syntax highlighting {{{
set t_Co=256
syntax on
set background=dark
colorscheme solarized
" }}}

" Mapleader {{{
let mapleader="\<Space>"
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
set encoding=utf-8 nobomb " BOM often causes trouble
set esckeys " Allow cursor keys in insert mode
set expandtab " Expand tabs to spaces
" set foldcolumn=0 " Column to show folds
" set foldenable " Enable folding
" set foldlevel=0 " Close all folds by default
" set foldmethod=manual " Syntax are used to specify folds
" set foldminlines=0 " Allow folding single lines
" set foldnestmax=10 " Set max fold nesting level
set nofoldenable " Disable fold.
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
set noshowmode " Don't show the current mode (airline.vim takes care of us)
set nostartofline " Don't reset cursor to start of line when moving around
set nowrap " Do not wrap lines
set nu " Enable line numbers
set ofu=syntaxcomplete#Complete " Set omni-completion method
set regexpengine=1 " Use the old regular expression engine (it's faster for certain language syntaxes)
set report=0 " Show all changes
set ruler " Show the cursor position
set scrolloff=6 " Start scrolling three lines before horizontal border of window
set shell=/bin/sh " Use /bin/sh for executing shell commands
set shiftwidth=2 " The # of spaces for indenting
set shortmess=atI " Don't show the intro message when starting vim
set showtabline=2 " Always show tab bar
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
set viminfo=%,'9999,s512,n~/.vim/viminfo " Restore buffer list, marks are remembered for 9999 files, registers up to 512Kb are remembered
set visualbell " Use visual bell instead of audible bell (annnnnoying)
set browsedir=buffer " browse files in same dir as open file
set wildchar=<TAB> " Character for CLI expansion (TAB-completion)
set wildignore+=.DS_Store
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js
" set wildignore+=*/.git/logs/*,*/.git/refs/*
set wildignore+=*/.git/*
set wildignore+=*/smarty/*,*/.hg/*,*/.svn/*,*/.sass-cache/*,*/log/*,*/tmp/*,*/build/*,*/ckeditor/*,*/doc/*,*/source_maps/*,*/dist/*
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
" }}}

" }}}

" Configuration -------------------------------------------------------------

" FastEscape {{{
" Speed up transition from modes
if ! has('gui_running')
  set timeoutlen=1000
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif
" }}}

" General {{{
augroup general_config
  autocmd!

  " Clear highlighting on escape in normal mode {{{
  " nnoremap <esc> :noh<return><esc>
  " nnoremap <esc>^[ <esc>^[
  " }}}

  " Disable arrow keys {{{
  nnoremap <Up> <NOP>
  nnoremap <Down> <NOP>
  nnoremap <Left> <NOP>
  nnoremap <Right> <NOP>
  " }}}

  " Speed up viewport scrolling {{{
  nnoremap <C-e> 3<C-e>
  nnoremap <C-y> 3<C-y>
  " }}}

  " Faster split resizing (+,-) {{{
  " if bufwinnr(1)
  "   nmap + <C-W>+
  "   nmap - <C-W>-
  "   nmap > <C-W>>
  "   nmap < <C-W><
  " endif
  " }}}

  " Better split switching (Ctrl-j, Ctrl-k, Ctrl-h, Ctrl-l) {{{
  " map <C-j> <C-W>j
  " map <C-k> <C-W>k
  " map <C-H> <C-W>h
  " map <C-L> <C-W>l
  " }}}

  " Sudo write (,W) {{{
  noremap <leader>w :w<CR>
  noremap <leader>W :w !sudo tee %<CR>
  " }}}

  " Get output of shell commands {{{
  command! -nargs=* -complete=shellcmd R new | setlocal buftype=nofile bufhidden=hide noswapfile | r !<args>
  " }}}

  " Remap :W to :w {{{
  command! W w
  " }}}

  " Better mark jumping (line + col) {{{
  nnoremap ' `
  " }}}

  " Hard to type things {{{
  " iabbrev >> →
  " iabbrev << ←
  " iabbrev ^^ ↑
  " iabbrev VV ↓
  " iabbrev aa λ
  " }}}

  " Toggle show tabs and trailing spaces (,c) {{{
  set lcs=tab:›\ ,trail:·,eol:¬,nbsp:_
  set fcs=fold:-
  nnoremap <silent> <leader>c :set nolist!<CR>
  " }}}

  " Clear last search (,qs) {{{
  map <silent> <leader>qs <Esc>:noh<CR>
  " map <silent> <leader>qs <Esc>:let @/ = ""<CR>
  " }}}

  " Vim on the iPad {{{
  if &term == "xterm-ipad"
    nnoremap <Tab> <Esc>
    vnoremap <Tab> <Esc>gV
    onoremap <Tab> <Esc>
    inoremap <Tab> <Esc>`^
    inoremap <Leader><Tab> <Tab>
  endif
  " }}}

  " Remap keys for auto-completion menu {{{
  inoremap <expr> <CR>   pumvisible() ? "\<C-y>" : "\<CR>"
  inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
  inoremap <expr> <Up>   pumvisible() ? "\<C-p>" : "\<Up>"
  " }}}

  " Paste toggle (,p) {{{
  " set pastetoggle=<leader>p
  map <leader>p :set invpaste paste?<CR>
  " }}}

  " Yank from cursor to end of line {{{
  nnoremap Y y$
  " }}}

  " Insert newline {{{
  map <leader><Enter> o<ESC>
  " }}}

  " Search and replace word under cursor (,*) {{{
  nnoremap <leader>* :%s/\<<C-r><C-w>\>//<Left>
  vnoremap <leader>* "hy:%s/\V<C-r>h//<left>
  " }}}

  " Join lines and restore cursor location (J) {{{
  nnoremap J mjJg`j:delmarks j<CR>
  " }}}

	" Remap logical movement to visual. {{{
	nnoremap <expr> j v:count ? 'j' : 'gj'
	nnoremap <expr> k v:count ? 'k' : 'gk'
	nnoremap gj j
	nnoremap gk k
	" }}}

  " Toggle folds (<Space>) {{{
  "nnoremap <silent> <space> :exe 'silent! normal! '.((foldclosed('.')>0)? 'zMzx' : 'zc')<CR>
  " }}}

  " Fix page up and down {{{
  map <PageUp> <C-U>
  map <PageDown> <C-D>
  imap <PageUp> <C-O><C-U>
  imap <PageDown> <C-O><C-D>
  " }}}

  " Relative numbers {{{
  set relativenumber " Use relative line numbers. Current line is still in status bar.
  au BufReadPost,BufNewFile * set relativenumber
  " }}}

  " Vimdiff {{{
  map <leader>dn ]c
  map <leader>dp [c
  map <leader>dr :diffget RE<CR>
  map <leader>db :diffget BA<CR>
  map <leader>dl :diffget LO<CR>
  " }}}

  " Tab mappings {{{
  "map <c-w> :tabc<CR>
  "map <c-PageUp> :tabn<CR>
  "map <c-PageDown> :tabp<CR>
  " }}}

  " Reload when entering the buffer or gaining focus {{{
  " au FocusGained,BufEnter,CursorHold * checktime
  " au FocusGained,BufEnter * :silent! !
  " au FileChangedShell * echo "File changed!"
  " }}}

  " Save when exiting the buffer or losing focus {{{
  "au FocusLost,WinLeave * :silent! w
  " }}}

  " Surround (,wb) (,wB) (,w#) {{{
  " map <leader>w ysiw
  " }}}

  " Search current selection {{{
  vnoremap // y/\V<C-R>"<CR>N
  vnoremap ?? y?\V<C-R>"<CR>
  " }}}

  " Move line (C-Up) (C-Down) {{{
  " How to find the code: Type ":<C-v><key map>" and copy copy without "^["
  nnoremap [1;5A mz:m-2<CR>`z==
  nnoremap [1;5B mz:m+<CR>`z==
  inoremap [1;5A <Esc>:m-2<CR>==gi
  inoremap [1;5B <Esc>:m+<CR>==gi
  vnoremap [1;5A :'<,'>m'<-2<CR>gv=`>my`<mzgv`yo`z
  vnoremap [1;5B :'<,'>m'>+<CR>gv=`<my`>mzgv`yo`z
  " }}}

  " Find and reset position {{{
  " nnoremap * *<c-o>
  " }}}

  " Color NonText (see listchars) {{{
  hi NonText ctermfg=10 guifg=#000000 guibg=#000000 ctermbg=8
  " }}}
augroup END
" }}}

" Create directory on save {{{
if !exists('*s:MkNonExDir')
  function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
      let dir=fnamemodify(a:file, ':h')
      if !isdirectory(dir)
        call mkdir(dir, 'p')
      endif
    endif
  endfunction
endif

augroup BWCCreateDir
    autocmd!
    au BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END
" }}}

" NERDTree {{{
augroup nerd_tree
  autocmd!

  map <leader>t :NERDTreeFind<CR>
augroup END
" }}}

" Buffers {{{
augroup buffer_control
  autocmd!

  " Prompt for buffer to select (,bs) {{{
  nnoremap <leader>bs :CtrlPBuffer<CR>
  " }}}

  " Buffer navigation (,,) (gb) (gB) (,ls) {{{
  map <leader><leader> <C-^>
  map <leader>ls :buffers<CR>
  map <leader>bn :bnext<CR>
  map <leader>bp :bprev<CR>
  map gb :bnext<CR>
  map gB :bprev<CR>
  " }}}

  " Open empty buffer {{{
  map <leader>bt :enew<CR>
  " }}}

  " Close current buffer and lint window {{{
  map <leader>bd :lclose<bar>b#<bar>bd #<CR>
  " }}}

  " Close all buffers {{{
  map <leader>bD :bufdo bd<CR>
  " }}}

  " Easy buffer navigation {{{
  "nnoremap [1;5D :bprevious<CR>
  "nnoremap [1;5C :bnext<CR>
  " }}}

  " Easy buffer navigation {{{
  nnoremap [1;5D <C-Left>
  nnoremap [1;5C <C-Right>
  inoremap [1;5D <ESC>Bi
  inoremap [1;5C <ESC>Wi
  cnoremap [1;5D <C-Left>
  cnoremap [1;5C <C-Right>
  " }}}

  " }}}


  " Jump to buffer number (<N>gb) {{{
  let c = 1
  while c <= 99
    execute "nnoremap " . c . "gb :" . c . "b\<CR>"
    let c += 1
  endwhile
  " }}}

  " Quickfix window (,qq) (,qo) (,qj) (,qk) {{{
  map <leader>qq :cclose<CR>
  map <leader>qo :copen<CR>
  map <leader>qj :cnext<CR>
  map <leader>qk :cprev<CR>
  map <leader>qc :cc<CR>
  " }}}

  " Location list window (,qq) (,qo) (,qj) (,qk) {{{
  map <leader>lq :lclose<CR>
  map <leader>lo :lopen<CR>
  map <leader>lj :lnext<CR>
  map <leader>lk :lprev<CR>
  map <leader>ll :ll<CR>
  " }}}

  " Preview window {{{
  map <leader>pq :pclose<CR>
  map <leader>pj :ptnext<CR>
  map <leader>pk :ptprevious<CR>
  " }}}
augroup END
" }}}

" Jumping to tags {{{
augroup jump_to_tags
  autocmd!

  " Basically, <c-]> jumps to tags (like normal) and <c-\> opens the tag in a new
  " split instead.
  "
  " Both of them will align the destination line to the upper middle part of the
  " screen.  Both will pulse the cursor line so you can see where the hell you
  " are.  <c-\> will also fold everything in the buffer and then unfold just
  " enough for you to see the destination line.
  " nnoremap <c-]> <c-]>mzzvzz15<c-e>`z:Pulse<cr>
  " nnoremap <c-\> <c-w>v<c-]>mzzMzvzz15<c-e>`z:Pulse<cr>

  " Pulse Line (thanks Steve Losh)
  function! s:Pulse() " {{{
    redir => old_hi
    silent execute 'hi CursorLine'
    redir END
    let old_hi = split(old_hi, '\n')[0]
    let old_hi = substitute(old_hi, 'xxx', '', '')

    let steps = 8
    let width = 1
    let start = width
    let end = steps * width
    let color = 233

    for i in range(start, end, width)
      execute "hi CursorLine ctermbg=" . (color + i)
      redraw
      sleep 6m
    endfor
    for i in range(end, start, -1 * width)
      execute "hi CursorLine ctermbg=" . (color + i)
      redraw
      sleep 6m
    endfor

    execute 'hi ' . old_hi
  endfunction " }}}

  command! -nargs=0 Pulse call s:Pulse()
augroup END
" }}}

" Highlight Interesting Words {{{
augroup highlight_interesting_word
  autocmd!
  " This mini-plugin provides a few mappings for highlighting words temporarily.
  "
  " Sometimes you're looking at a hairy piece of code and would like a certain
  " word or two to stand out temporarily.  You can search for it, but that only
  " gives you one color of highlighting.  Now you can use <leader>N where N is
  " a number from 1-6 to highlight the current word in a specific color.
  function! HiInterestingWord(n) " {{{
    " Save our location.
    normal! mz

    " Yank the current word into the z register.
    normal! "zyiw

    " Calculate an arbitrary match ID.  Hopefully nothing else is using it.
    let mid = 86750 + a:n

    " Clear existing matches, but don't worry if they don't exist.
    silent! call matchdelete(mid)

    " Construct a literal pattern that has to match at boundaries.
    let pat = '\V\<' . escape(@z, '\') . '\>'

    " Actually match the words.
    call matchadd("InterestingWord" . a:n, pat, 1, mid)

    " Move back to our original location.
    normal! `z
  endfunction " }}}

  " Mappings {{{
  nnoremap <silent> <leader>1 :call HiInterestingWord(1)<cr>
  nnoremap <silent> <leader>2 :call HiInterestingWord(2)<cr>
  nnoremap <silent> <leader>3 :call HiInterestingWord(3)<cr>
  nnoremap <silent> <leader>4 :call HiInterestingWord(4)<cr>
  nnoremap <silent> <leader>5 :call HiInterestingWord(5)<cr>
  nnoremap <silent> <leader>6 :call HiInterestingWord(6)<cr>
  nnoremap <silent> <leader>7 :call HiInterestingWord(7)<cr>
  " }}}

  " Default Highlights {{{
  hi def InterestingWord1 guifg=#000000 ctermfg=16 guibg=#ffa724 ctermbg=214
  hi def InterestingWord2 guifg=#000000 ctermfg=16 guibg=#aeee00 ctermbg=154
  hi def InterestingWord3 guifg=#000000 ctermfg=16 guibg=#8cffba ctermbg=121
  hi def InterestingWord4 guifg=#000000 ctermfg=16 guibg=#b88853 ctermbg=137
  hi def InterestingWord5 guifg=#000000 ctermfg=16 guibg=#ff9eb8 ctermbg=211
  hi def InterestingWord6 guifg=#000000 ctermfg=16 guibg=#ff2c4b ctermbg=195
  hi def InterestingWord7 guifg=#000000 ctermfg=16 guibg=#ff0000 ctermbg=red

  " Transparent background {{{
  hi Normal guibg=NONE ctermbg=NONE
  hi NonText guibg=NONE ctermbg=NONE
  " }}}
augroup END
" }}}

" Word Processor Mode {{{
augroup word_processor_mode
  autocmd!

  function! s:goyo_enter()
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

  function! s:goyo_leave()
  endfunction

  au User GoyoEnter nested call <SID>goyo_enter()
  au User GoyoLeave nested call <SID>goyo_leave()
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

" Automatically equalize splits when vim is resized {{{
augroup auto_resize
	autocmd!
	autocmd VimResized * wincmd =
augroup END
" }}}

" Multiple cursors {{{
augroup multiple_cursor
  autocmd!
  let g:mc = "y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>"

  nnoremap cn *``cgn
  nnoremap cN *``cgN

  vnoremap <expr> cn g:mc . "``cgn"
  vnoremap <expr> cN g:mc . "``cgN"

  function! SetupCR()
    nnoremap <Enter> :nnoremap <lt>Enter> n@z<CR>q:<C-u>let @z=strpart(@z,0,strlen(@z)-1)<CR>n@z
  endfunction

  nnoremap cq :call SetupCR()<CR>*``qz
  nnoremap cQ :call SetupCR()<CR>#``qz

  vnoremap <expr> cq ":\<C-u>call SetupCR()\<CR>" . "gv" . g:mc . "``qz"
  vnoremap <expr> cQ ":\<C-u>call SetupCR()\<CR>" . "gv" . substitute(g:mc, '/', '?', 'g') . "``qz"
augroup END


" Custom commands ------------------------------------------------------

augroup custom_commands
  autocmd!

  " Format json.
  command! -nargs=0 FormatJSON execute "%!python -m json.tool"

  " Copy current file path.
  command! -nargs=0 CopyPath execute "let @+ = expand('%')"
augroup END

" Filetypes -------------------------------------------------------------

" C {{{
augroup filetype_c
  autocmd!

  " Highlight Custom C Types {{{
  autocmd BufRead,BufNewFile *.[ch] let fname = expand('<afile>:p:h') . '/types.vim'
  autocmd BufRead,BufNewFile *.[ch] if filereadable(fname)
  autocmd BufRead,BufNewFile *.[ch]   exe 'so ' . fname
  autocmd BufRead,BufNewFile *.[ch] endif
  " }}}
augroup END
" }}}

" Clojure {{{
augroup filetype_clojure
  autocmd!
  let g:vimclojure#ParenRainbow = 1 " Enable rainbow parens
  let g:vimclojure#DynamicHighlighting = 1 " Dynamic highlighting
  let g:vimclojure#FuzzyIndent = 1 " Names beginning in 'def' or 'with' to be indented as if they were included in the 'lispwords' option
augroup END
" }}}

" Coffee {{{
augroup filetype_coffee
  autocmd!
  au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
augroup END
" }}}

" Fish {{{
augroup filetype_fish
  autocmd!
  au BufRead,BufNewFile *.fish set ft=fish
augroup END
" }}}

" Handlebars {{{
augroup filetype_hbs
  autocmd!
  au BufRead,BufNewFile *.hbs,*.handlebars,*.hbs.erb,*.handlebars.erb setl ft=mustache syntax=mustache
augroup END
" }}}

" Jade {{{
augroup filetype_jade
  autocmd!
  au BufRead,BufNewFile *.jade set ft=jade syntax=jade
augroup END
" }}}

" JavaScript {{{
augroup filetype_javascript
  autocmd!
  " Load ES6 snippets
  au FileType js UltiSnipsAddFiletypes javascript-es6

  " General conceal settings. Will keep things concealed
  set conceallevel=0
  "set concealcursor=nc

  " even when your cursor is on top of them.
  let g:javascript_conceal_function             = "ƒ"
  let g:javascript_conceal_null                 = "ø"
  let g:javascript_conceal_this                 = "@"
  let g:javascript_conceal_return               = "⇚"
  let g:javascript_conceal_undefined            = "¿"
  let g:javascript_conceal_NaN                  = "ℕ"
  let g:javascript_conceal_prototype            = "¶"
  let g:javascript_conceal_static               = "•"
  let g:javascript_conceal_super                = "Ω"
  let g:javascript_conceal_arrow_function       = "⇒"
  let g:javascript_conceal_noarg_arrow_function = "🞅"
  let g:javascript_conceal_underscore_arrow_function = "🞅"

  " Enable plugins.
  let g:javascript_plugin_jsdoc = 1
augroup END
" }}}

" Markdown {{{
augroup filetype_markdown
  autocmd!
  au FileType markdown set wrap
  let g:markdown_fenced_languages = ['ruby', 'html', 'javascript', 'css', 'erb=eruby.html', 'bash=sh']
augroup END
" }}}

" Nu {{{
augroup filetype_nu
  autocmd!
  au BufNewFile,BufRead *.nu,*.nujson,Nukefile setf nu
augroup END
" }}}

" Ruby {{{
augroup filetype_ruby
  autocmd!

  au BufRead,BufNewFile Rakefile,Capfile,Gemfile,.autotest,.irbrc,*.treetop,*.tt set ft=ruby syntax=ruby nofoldenable

  " Ruby.vim {{{
  let ruby_operators = 1
  let ruby_space_errors = 1
  let ruby_fold = 0
  " }}}
augroup END
" }}}

" }}}
" XML {{{
augroup filetype_xml
  autocmd!
  au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"
augroup END
" }}}

" ZSH {{{
augroup filetype_zsh
  autocmd!
  au BufRead,BufNewFile .zsh_rc,.functions,.commonrc set ft=zsh
augroup END
" }}}

" CSV {{{
augroup filetype_csv
  autocmd!
  au BufRead,BufNewFile *.csv,*.dat set ft=csv
augroup END
" }}}

" Plugin Configuration -------------------------------------------------------------

" Solarized.vim {{{
augroup solarized_config
  autocmd!
  " let g:solarized_termcolors = 256
  " let g:solarized_termtrans = 1
augroup END
" }}}

" Airline.vim {{{
augroup airline_config
  autocmd!
  let g:airline_theme = 'base16'
  let g:airline_powerline_fonts = 1
  let g:airline_enable_syntastic = 1
  let g:airline#extensions#syntastic#enabled = 1
  let g:airline#extensions#tabline#buffer_nr_format = '%s '
  let g:airline#extensions#tabline#buffer_nr_show = 1
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#fnamecollapse = 0
  let g:airline#extensions#tabline#fnamemod = ':t'
  let g:airline#extensions#whitespace#mixed_indent_algo = 1
augroup END
" }}}

" CtrlP.vim {{{
augroup ctrlp_config
  autocmd!
  let g:ctrlp_clear_cache_on_exit = 0 " Do not clear filenames cache, to improve CtrlP startup
  let g:ctrlp_lazy_update = 350 " Set delay to prevent extra search
  let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' } " Use python fuzzy matcher for better performance
  let g:ctrlp_match_window_bottom = 0 " Show at top of window
  let g:ctrlp_max_files = 0 " Set no file limit, we are building a big project
  let g:ctrlp_switch_buffer = 'Et' " Jump to tab AND buffer if already open
  let g:ctrlp_open_new_file = 'r' " Open newly created files in the current window
  let g:ctrlp_open_multiple_files = 'ij' " Open multiple files in hidden buffers, and jump to the first one
  let g:ctrlp_working_path_mode = 'r' " Use the nearest .git directory as the cwd
  let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
augroup END
" }}}

" Silver Searcher {{{
augroup ag_config
  autocmd!
  cnoreabbrev Ack Ack!

  if executable("rg")
    " Note we extract the column as well as the file and line number
    set grepprg=rg\ --no-heading\ --vimgrep\ --smart-case\ --color=never
    set grepformat=%f:%l:%c:%m,%f:%l:%m

    " Have the silver searcher ignore all the same things as wilgignore
    let b:rg_command = 'rg %s --files --ignore-case --color=never --hidden'
    let b:globs = ' '

    " Add ignore list.
    for i in split(&wildignore, ",")
      let b:globs = b:globs . '--glob "!' . substitute(i, '\*/\(.*\)/\*', '\1', 'g') . '" '
    endfor

    let g:ackprg = 'rg --no-heading --vimgrep --smart-case --ignore-case --hidden' . b:globs
    let g:ctrlp_user_command = b:rg_command . b:globs
  endif
augroup END
" }}}

" EasyAlign.vim {{{
augroup easy_align_config
  autocmd!
  " Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
  vmap <Enter> <Plug>(EasyAlign)
  " Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
  nmap <Leader>a <Plug>(EasyAlign)
augroup END
" }}}

" Notes.vim {{{
augroup notes_config
  autocmd!
  let g:notes_directories = ['~/Dropbox/Notes']
augroup END
" }}}

" RainbowParenthesis.vim {{{
augroup rainbow_parenthesis_config
  autocmd!
  nnoremap <leader>rp :RainbowParenthesesToggle<CR>
augroup END
" }}}

" Syntastic.vim {{{
augroup syntastic_config
  autocmd!
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_loc_list_height = 5
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0
  let g:syntastic_error_symbol = '✗'
  let g:syntastic_warning_symbol = '⚠'
  let g:syntastic_ruby_checkers = ['mri', 'rubocop']
  let g:syntastic_javascript_checkers = ['eslint']

  highlight link SyntasticError InterestingWord7
  highlight link SyntasticWarning InterestingWord7
augroup END
" }}}

" Ale.vim {{{
augroup ale_config
  autocmd!
  let g:ale_sign_error = '✗'
  let g:ale_sign_warning = '⚠'
  let g:ale_linters = { 'javascript': ['eslint'], 'python': ['pylint'], 'rust': ['rls'] }
augroup END
" }}}

" EditorConfig.vim {{{
augroup editorconfig_config
  autocmd!
  let g:EditorConfig_exclude_patterns = ['fugitive://.*']
augroup END
" }}}

" EasyMotion.vim {{{
augroup easymotion_config
  autocmd!
  " s{char}{char} to move to {char}{char}
  nmap s <Plug>(easymotion-s2)
  nmap t <Plug>(easymotion-t2)

  " Repeat motion.
  map <Leader>. <Plug>(easymotion-repeat)

  let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
augroup END
" }}}

" IncSearch.vim {{{
augroup incsearch_config
  autocmd!
  " You can use other keymappings like <C-l> instead of <CR> if you want to
  " use these mappings as default search and somtimes want to move cursor with
  " EasyMotion.
  "function! s:incsearch_config(...) abort
  "  return incsearch#util#deepextend(deepcopy({
  "        \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
  "        \   'keymap': {
  "        \     "\<CR>": '<Over>(easymotion)'
  "        \   },
  "        \   'is_expr': 0
  "        \ }), get(a:, 1, {}))
  "endfunction

  "noremap <silent><expr> /  incsearch#go(<SID>incsearch_config())
  "noremap <silent><expr> ?  incsearch#go(<SID>incsearch_config({'command': '?'}))
  "noremap <silent><expr> g/ incsearch#go(<SID>incsearch_config({'is_stay': 1}))

  " basic config
  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)

  " :h g:incsearch#auto_nohlsearch
  let g:incsearch#auto_nohlsearch = 0
  map n  <Plug>(incsearch-nohl-n)
  map N  <Plug>(incsearch-nohl-N)
  map *  <Plug>(incsearch-nohl-*)
  map #  <Plug>(incsearch-nohl-#)
  map g* <Plug>(incsearch-nohl-g*)
  map g# <Plug>(incsearch-nohl-g#)

  " fuzzy search
  map z/ <Plug>(incsearch-fuzzy-/)
  map z? <Plug>(incsearch-fuzzy-?)
  map zg/ <Plug>(incsearch-fuzzy-stay)
augroup END
" }}}

" YouCompleteMe.vim {{{
augroup youcompleteme_config
  autocmd!
  let g:ycm_auto_trigger = 1
  let g:ycm_min_num_of_chars_for_completion = 2
  let g:ycm_server_python_interpreter = "/usr/bin/python"
  let g:ycm_complete_in_comments = 1
  let g:ycm_complete_in_strings = 1
  let g:ycm_collect_identifiers_from_comments_and_strings = 1
  let g:ycm_seed_identifiers_with_syntax = 1
  let g:ycm_autoclose_preview_window_after_completion = 1
augroup END
" }}}

" UltiSnips.vim {{{
augroup ultisnips_config
  autocmd!
  " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
  let g:UltiSnipsExpandTrigger="<c-s>"
  let g:UltiSnipsJumpForwardTrigger="<c-b>"
  let g:UltiSnipsJumpBackwardTrigger="<c-z>"

  " If you want :UltiSnipsEdit to split your window.
  let g:UltiSnipsEditSplit="vertical"
augroup END
" }}}

" SuperTab.vim {{{
augroup supertab_config
  autocmd!
  let g:SuperTabDefaultCompletionType    = '<C-n>'
  " let g:SuperTabCrMapping                = 0
augroup END
" }}}

" Fugitive.vim {{{
augroup fugitive_config
  autocmd!
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
augroup END
" }}}

" Emoji.vim {{{
augroup emoji_config
  autocmd!
  au FileType markdown set omnifunc=emoji#complete
augroup END
" }}}

" BetterWhitespace.vim {{{
augroup betterwhitespace_config
  autocmd!
  autocmd BufWritePre * StripWhitespace
augroup END
" }}}

" MultipleCursor.vim {{{
augroup multiplecursor_config
  autocmd!
  " Remove default mappings.
  let g:multi_cursor_use_default_mapping=0

  " Remap.
  let g:multi_cursor_next_key='<C-n>'
  let g:multi_cursor_prev_key='<C-b>'
  let g:multi_cursor_skip_key='<C-q>'
  let g:multi_cursor_quit_key='<Esc>'

  " Edit current search.
  nnoremap <silent> <F3> :MultipleCursorsFind <C-R>/<CR>
  vnoremap <silent> <F3> :MultipleCursorsFind <C-R>/<CR>
augroup END
" }}}

" Undotree.vim {{{
augroup undotree_config
  autocmd!
  noremap <silent> <F6> :UndotreeToggle<CR>
augroup END
" }}}

" AutoPairs.vim {{{
augroup autopairs_config
  autocmd!
  let g:AutoPairsMultilineClose=0
augroup END
" }}}

" ExpandRegion.vim {{{
augroup expandregion_config
  autocmd!
  vmap v <Plug>(expand_region_expand)
  vmap <C-v> <Plug>(expand_region_shrink)
augroup END
" }}}

" Peekaboo.vim {{{
augroup peekaboo_config
  autocmd!
  let g:peekaboo_delay = 750
augroup END
" }}}

" SmoothScroll.vim {{{
augroup smoothscroll_config
  autocmd!
  noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
  noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
  noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
  noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>
augroup END
" }}}

" neocomplete.vim {{{
augroup neocomplete_config
  autocmd!
  let g:acp_enableAtStartup = 0 " Disable AutoComplPop.
  let g:neocomplete#enable_at_startup = 1 " Use neocomplete.
  let g:neocomplete#enable_smart_case = 1 " Use smartcase.
  let g:neocomplete#enable_auto_close_preview = 1 " Close preview window automatically.
  let g:neocomplete#sources#syntax#min_keyword_length = 3 " Set minimum syntax keyword length.
  let g:neopairs#enable = 1 " Enable neo pairs.

  " Define keyword.
  if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
  endif
  let g:neocomplete#keyword_patterns['default'] = '\h\w*'

  " Plugin key-mappings.
  inoremap <expr><C-g>     neocomplete#undo_completion()
  inoremap <expr><C-l>     neocomplete#complete_common_string()

  " Recommended key-mappings.
  " <CR>: close popup and save indent.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? "\<C-y>" : "\<CR>"
  endfunction
  " <TAB>: completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
  " Close popup by <Space>.
  "inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

  " AutoComplPop like behavior.
  "let g:neocomplete#enable_auto_select = 1

  " Shell like behavior(not recommended).
  "set completeopt+=longest
  "let g:neocomplete#enable_auto_select = 1
  "let g:neocomplete#disable_auto_complete = 1
  "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

  " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

  " Enable heavy omni completion.
  if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
  endif
  "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
  "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
  "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

  " For perlomni.vim setting.
  " https://github.com/c9s/perlomni.vim
  let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

augroup END
" }}}

" neosnippet.vim {{{
augroup neosnippet_config
  autocmd!
  " Plugin key-mappings.
  " Note: It must be "imap" and "smap".  It uses <Plug> mappings.
  imap <C-s>     <Plug>(neosnippet_expand_or_jump)
  smap <C-s>     <Plug>(neosnippet_expand_or_jump)
  xmap <C-s>     <Plug>(neosnippet_expand_target)

  " SuperTab like snippets behavior.
  " Note: It must be "imap" and "smap".  It uses <Plug> mappings.
  imap <C-s>     <Plug>(neosnippet_expand_or_jump)
  "imap <expr><TAB>
  " \ pumvisible() ? "\<C-n>" :
  " \ neosnippet#expandable_or_jumpable() ?
  " \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
        \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

  " For conceal markers.
  " if has('conceal')
  "   set conceallevel=2 concealcursor=niv
  " endif

  " Enable snipMate compatibility feature.
  let g:neosnippet#enable_snipmate_compatibility = 1

  " Tell Neosnippet about the other snippets
  let g:neosnippet#snippets_directory=[
        \ '~/.vim/plugged/vim-snippets/snippets',
        \ '~/.vim/plugged/neosnippet-snippets/neosnippets',
        \ '~/.vim/snippets',
        \ '~/.vim/my-snippets',
        \ ]
augroup END
" }}}

" vim_diff_enhanced.vim {{{
augroup vim_diff_enhanced_config
  autocmd!
  " started In Diff-Mode set diffexpr (plugin not loaded yet)
  if &diff
    let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
  endif
augroup END
" }}}

" vim_vmath.vim {{{
augroup vim_vmath_config
  autocmd!
  vmap <expr>  ++  VMATH_YankAndAnalyse()
  nmap         ++  vip++
augroup END
" }}}

" vim_markdown_composer {{{
augroup vim_markdown_composer
  autocmd!
  " Installation function.
  function! BuildComposer(info)
    if a:info.status != 'unchanged' || a:info.force
      if has('nvim')
        !cargo build --release
      else
        !cargo build --release --no-default-features --features json-rpc
      endif
    endif
  endfunction

  " Options.
  let g:markdown_composer_refresh_rate = 250
  let g:markdown_composer_autostart = 0
augroup END
" }}}

" vim_move.vim {{{
augroup vim_move
  autocmd!
  " Disable key bindings.
  let g:move_map_keys = 0
augroup END
" }}}

" vim_startify.vim {{{
augroup vim_startify
  autocmd!
  let g:startify_change_to_dir = 0
augroup END
" }}}

" vim_table_mode.vim {{{
augroup vim_table_mode
  autocmd!
  let g:table_mode_map_prefix = '<Leader>f'
augroup END
" }}}

" vim_dispatch.vim {{{
augroup vim_dispatch
  autocmd!
  nnoremap <F9> :Dispatch<CR>
augroup END
" }}}

" vim_checklist.vim {{{
augroup vim_checklist
  autocmd!
  nnoremap <leader>ct :ChecklistToggleCheckbox<cr>
  nnoremap <leader>ce :ChecklistEnableCheckbox<cr>
  nnoremap <leader>cd :ChecklistDisableCheckbox<cr>
  vnoremap <leader>ct :ChecklistToggleCheckbox<cr>
  vnoremap <leader>ce :ChecklistEnableCheckbox<cr>
  vnoremap <leader>cd :ChecklistDisableCheckbox<cr>
  let g:checklist_filetypes = ['notes', 'markdown', 'text']
augroup END
" }}}

" vim_racer.vim {{{
augroup vim_racer
  autocmd!
  let g:racer_cmd = "$HOME/.cargo/bin/racer"
  let g:racer_experimental_completer = 1
augroup END
" }}}

" Plugins -------------------------------------------------------------

" Load plugins {{{
call plug#begin('~/.vim/plugged')

Plug 'ap/vim-css-color'
Plug 'bling/vim-airline'
" Plug 'guns/vim-clojure-static'
" Plug 'joker1007/vim-ruby-heredoc-syntax'
Plug 'junegunn/vim-easy-align'
" Plug 'junegunn/vim-emoji'
Plug 'junegunn/goyo.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'kien/rainbow_parentheses.vim'
Plug 'mustache/vim-mustache-handlebars'
Plug 'nathanaelkane/vim-indent-guides'
" Plug 'oplatek/Conque-Shell'
Plug 'pangloss/vim-javascript'
" Plug 'rking/ag.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeFind' }
Plug 'tpope/vim-commentary'
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeFind' }
" Plug 'scrooloose/syntastic'
" Plug 'slim-template/vim-slim', { 'for': 'slim' }
" Plug 'thoughtbot/vim-rspec'
" Plug 'tpope/vim-haml'
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
" Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-git'
Plug 'tpope/vim-unimpaired'
" Plug 'tpope/vim-fugitive' " Currently broken.
" Plug 'vim-ruby/vim-ruby'
" Plug 'vim-scripts/fish.vim',   { 'for': 'fish' }
" Plug 'vim-scripts/jade.vim',   { 'for': 'jade' }
" Plug 'wavded/vim-stylus',      { 'for': 'stylus' }
" Plug 'wlangstroth/vim-racket'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
Plug 'editorconfig/editorconfig-vim'
" Plug 'MarcWeber/vim-addon-mw-utils'
" Plug 'tomtom/tlib_vim'
" Plug 'SirVer/ultisnips'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'Shougo/neocomplete.vim'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neco-syntax'
Plug 'Shougo/neopairs.vim'
Plug 'honza/vim-snippets'
" Plug 'danro/rename.vim'
Plug 'mileszs/ack.vim'
" Plug 'severin-lemaignan/vim-minimap'
" Plug 'junegunn/vim-peekaboo'
" Plug 'justinmk/vim-sneak'
" Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
" Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
" Plug 'PeterRincker/vim-argumentative'
Plug 'Olical/vim-enmasse'
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' }
Plug 'elzr/vim-json', { 'for': 'json' }
" Plug 'rickhowe/diffchar.vim'
Plug 'tpope/vim-dispatch'
" Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'jiangmiao/auto-pairs'
" Plug 'kshenoy/vim-signature'
Plug 'christoomey/vim-tmux-navigator'
Plug 'airblade/vim-gitgutter'
Plug 'ntpeters/vim-better-whitespace'
" Plug 'Chiel92/vim-autoformat'
Plug 'terryma/vim-multiple-cursors'
Plug 'w0rp/ale'
" Plug 'mbbill/undotree'
Plug 'altercation/vim-colors-solarized'
Plug 'joukevandermaas/vim-ember-hbs'
" Plug 'andrewradev/ember_tools.vim'
Plug 'alexlafroscia/vim-ember-cli'
" Plug 'alexbyk/vim-ultisnips-js-testing'
Plug 'vim-airline/vim-airline-themes'
" Plug 'francoiscabrol/ranger.vim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'terryma/vim-expand-region'
" Plug 'jebaum/vim-tmuxify'
" Plug 'yuttie/comfortable-motion.vim'
Plug 'terryma/vim-smooth-scroll'
Plug 'mhinz/vim-startify'
" Plug 'ervandew/supertab'
Plug 'chrisbra/vim-diff-enhanced'
Plug 'fcpg/vim-altscreen'
Plug 'mjbrownie/swapit'
Plug 'chrisbra/vim-zsh', { 'for': 'zsh' }
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'brennier/quicktex', { 'for': 'tex' }
Plug 'beloglazov/vim-online-thesaurus'
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
" Plug 't9md/vim-quickhl'
" Plug 'dsawardekar/portkey'
" Plug 'dsawardekar/ember.vim'
Plug 'nixon/vim-vmath'
" Plug 'tpope/vim-vinegar'
Plug 'majutsushi/tagbar'
" Plug 'matze/vim-move'
Plug 'euclio/vim-markdown-composer', { 'for' : 'markdown', 'do': function('BuildComposer') }
Plug 'digitaltoad/vim-pug'
Plug 'kshenoy/vim-signature'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'esalter-va/vim-checklist'
Plug 'cespare/vim-toml'
Plug 'mboughaba/i3config.vim'
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'

call plug#end()
" }}}
