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
colorscheme solarized
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
set esckeys " Allow cursor keys in insert mode
" set expandtab " Expand tabs to spaces
set foldenable " Enable folding
set foldcolumn=0 " Column to show folds
set foldlevel=0 " Close all folds by default
set foldlevelstart=-1 " Start fold level
set foldmethod=syntax " Syntax are used to specify folds
set foldminlines=0 " Allow folding single lines
set foldnestmax=10 " Set max fold nesting level
set foldclose=all " Close as you walk out a fold
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
set clipboard=autoselect
set listchars=tab:\¦\ ,trail:·,eol:¬,nbsp:_
set fillchars=fold:-
set relativenumber " Use relative line numbers. Current line is still in status bar.
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

  " Sudo write (,W) {{{
  noremap <leader>w :w<CR>
  noremap <leader>W :w !sudo tee %<CR>
  " }}}

  " Get output of shell commands (:R echo foo) {{{
  command! -nargs=* -complete=shellcmd R new | setlocal buftype=nofile bufhidden=hide noswapfile | r !<args>
  " }}}

  " Remap :W to :w {{{
  command! W w
  " }}}

  " Better mark jumping (line + col) {{{
  nnoremap ' `
  " }}}

  " Toggle show tabs and trailing spaces (,c) {{{
  nnoremap <silent> <leader>v :set nolist!<CR>
  " }}}

  " Disable space behaviour {{{
  nnoremap <space> <NOP>
  " }}}

  " Clear last search (,qs) {{{
  nnoremap <silent> <leader>qs :noh<CR>
  " map <silent> <leader>qs <Esc>:let @/ = ""<CR>
  " }}}

  " Remap keys for auto-completion menu {{{
  inoremap <expr> <CR>   pumvisible() ? "\<C-y>" : "\<CR>"
  inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
  inoremap <expr> <Up>   pumvisible() ? "\<C-p>" : "\<Up>"
  " }}}

  " Paste toggle (,p) {{{
  nnoremap <leader>p :set invpaste paste?<CR>
  " }}}

  " Yank from cursor to end of line {{{
  nnoremap Y y$
  " }}}

  " Insert newline {{{
  nnoremap <leader><Enter> o<ESC>
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

  " Fix page up and down {{{
  map <PageUp> <C-U>
  map <PageDown> <C-D>
  imap <PageUp> <C-O><C-U>
  imap <PageDown> <C-O><C-D>
  " }}}

  " Vimdiff {{{
  map <leader>dn ]c
  map <leader>dp [c
  map <leader>dr :diffget RE<CR>
  map <leader>db :diffget BA<CR>
  map <leader>dl :diffget LO<CR>
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
augroup END
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

" NERDTree {{{
augroup nerd_tree
  autocmd!
  nnoremap <leader>t :NERDTreeFind<CR>
augroup END
" }}}

" Buffers {{{
augroup buffer_control
  autocmd!
  nnoremap <leader>bs :Buffers<CR>
  nnoremap <leader>bt :enew<CR>
  nnoremap <leader>bd :lclose<bar>b#<bar>bd #<CR>
  nnoremap <leader>bD :bufdo bd<CR>
  nnoremap <leader><leader> <c-^>

  " Jump to buffer number (<N>gb) {{{
  let g:c = 1
  while g:c <= 99
    execute 'nnoremap ' . g:c . 'gb :' . g:c . 'b\<CR>'
    let g:c += 1
  endwhile
  " }}}

  " Quickfix window (,qq) (,qo) (,qj) (,qk) {{{
  nnoremap <leader>qq :cclose<CR>
  nnoremap <leader>qo :copen<CR>
  nnoremap <leader>qj :cnext<CR>
  nnoremap <leader>qk :cprev<CR>
  nnoremap <leader>qc :cc<CR>
  " }}}

  " Location list window (,qq) (,qo) (,qj) (,qk) {{{
  nnoremap <leader>lq :lclose<CR>
  nnoremap <leader>lo :lopen<CR>
  nnoremap <leader>lj :lnext<CR>
  nnoremap <leader>lk :lprev<CR>
  nnoremap <leader>ll :ll<CR>
  " }}}

  " Preview window {{{
  nnoremap <leader>pq :pclose<CR>
  nnoremap <leader>pj :ptnext<CR>
  nnoremap <leader>pk :ptprevious<CR>
  " }}}
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

" Highlight Interesting Words {{{
augroup highlight_interesting_word
  autocmd!
  " This mini-plugin provides a few mappings for highlighting words temporarily.
  "
  " Sometimes you're looking at a hairy piece of code and would like a certain
  " word or two to stand out temporarily.  You can search for it, but that only
  " gives you one color of highlighting.  Now you can use <leader>N where N is
  " a number from 1-6 to highlight the current word in a specific color.
  function! HiInterestingWord(n) abort " {{{
    " Save our location.
    normal! mz

    " Yank the current word into the z register.
    normal! "zyiw

    " Calculate an arbitrary match ID.  Hopefully nothing else is using it.
    let l:mid = 86750 + a:n

    " Clear existing matches, but don't worry if they don't exist.
    silent! call matchdelete(l:mid)

    " Construct a literal pattern that has to match at boundaries.
    let l:pat = '\V\<' . escape(@z, '\') . '\>l:mid'

    " Actually match the words.
    call matchadd('InterestingWord' . a:n, l:pat, 1, l:mid)

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

  " Color (see listchars) {{{
  hi NonText ctermfg=10 ctermbg=8 guifg=#000000 guibg=#000000
  hi SpecialKey term=NONE cterm=NONE
  " }}}
augroup END
" }}}

" Word Processor Mode {{{
augroup word_processor_mode
  autocmd!
  function! s:goyo_enter() abort
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

  function! s:goyo_leave() abort
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
  au BufNewFile,BufReadPost *.coffee setl foldmethod=indent
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
  au BufRead,BufNewFile *.handlebars,*.hbs.erb,*.handlebars.erb setl ft=mustache syntax=mustache
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
  " General conceal settings. Will keep things concealed
  set conceallevel=0
  "set concealcursor=nc

  " even when your cursor is on top of them.
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

  " Enable plugins.
  let g:javascript_plugin_jsdoc = 1
augroup END
" }}}

" Markdown {{{
augroup filetype_markdown
  autocmd!
  au FileType markdown set wrap
  let g:markdown_fenced_languages = ['ruby', 'html', 'javascript', 'css', 'erb=eruby.html', 'bash=sh', 'handlebars', 'json']
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

  au BufRead,BufNewFile Rakefile,Capfile,Gemfile,.autotest,.irbrc,*.treetop,*.tt set ft=ruby syntax=ruby

  " Ruby.vim {{{
  let g:ruby_operators = 1
  let g:ruby_space_errors = 1
  let g:ruby_fold = 1
  " }}}
augroup END
" }}}

" XML {{{
" augroup filetype_xml
"   autocmd!
"   au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"
" augroup END
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

" JSON {{{
augroup filetype_json
  autocmd!
  au FileType json setlocal equalprg=python\ -m\ json.tool
augroup END
" }}}

" Bash {{{
augroup filetype_bash
  autocmd!
  au FileType sh setlocal formatprg=shfmt\ -bn\ -ci
augroup END
" }}}

" Bats {{{
augroup filetype_bats
  autocmd!
  au BufNewFile,BufReadPost *.bats exe ":ALEDisableBuffer"
augroup END
" }}}

" Plugin Configuration -------------------------------------------------------------

" Lightline.vim {{{
augroup lightline_config
  autocmd!
  let g:lightline = {
    \ 'colorscheme': 'solarized',
    \ }
augroup END
" }}}
"
" fzf.vim {{{
augroup fzf_config
  autocmd!
  " Config.
  let g:fzf_layout = { 'up': '~40%' }
  let g:fzf_history_dir = '~/.local/share/fzf-history'
  " Configure fzf for brew
  set runtimepath+=/usr/local/opt/fzf
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
augroup END
" }}}

" Silver Searcher {{{
augroup ag_config
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

" Ale.vim {{{
augroup ale_config
  autocmd!
  let g:ale_sign_error = '✗'
  let g:ale_sign_warning = '⚠'
  let g:ale_linters = {
        \ 'tex': ['chktex'],
        \ 'javascript': ['eslint'],
        \ 'python': ['pylint'],
        \ 'rust': ['rls'],
        \ }
augroup END
" }}}

" EditorConfig.vim {{{
augroup editorconfig_config
  autocmd!
  let g:EditorConfig_exclude_patterns = ['fugitive://.*']
augroup END
" }}}

" incsearch_highlight.vim {{{
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
  au FileType markdown setlocal omnifunc=emoji#complete
augroup END
" }}}

" BetterWhitespace.vim {{{
augroup betterwhitespace_config
  autocmd!
  autocmd BufWritePre * StripWhitespace
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

" SmoothScroll.vim {{{
augroup smoothscroll_config
  autocmd!
  noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
  noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
  noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
  noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>
augroup END
" }}}

" deoplete.vim {{{
augroup deoplete_config
  autocmd!
  " Config.
  if has('python3')
    let g:deoplete#enable_at_startup = 1
    let g:deoplete#enable_yarp = 1
  endif

	" <C-h>, <BS>: close popup and delete backword char.
	inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
	inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"

  " <TAB>: completion.
  inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
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
  let g:neosnippet#enable_completed_snippet = 1

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
  function! BuildComposer(info) abort
    if a:info.status !=# 'unchanged' || a:info.force
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
  let g:table_mode_corner = '|'
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

" vim_sad.vim {{{
augroup vim_sad
  autocmd!
  nmap sn <Plug>(sad-change-forward)
  nmap sp <Plug>(sad-change-backward)
augroup END
" }}}

" vim_racer.vim {{{
augroup vim_racer
  autocmd!
  let g:racer_cmd = '$HOME/.cargo/bin/racer'
  let g:racer_experimental_completer = 1
augroup END
" }}}

" vim_lsp.vim {{{
augroup vim_lsp
  autocmd!
  " Config.
  let g:LanguageClient_serverCommands = {
      \ 'javascript': ['javascript-typescript-stdio'],
      \ 'python': ['pyls'],
      \ }
  let g:LanguageClient_diagnosticsList = 'Location'

  " Keybindings.
  nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
  nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
augroup END
" }}}

" vim_tex.vim {{{
augroup vim_tex
  autocmd!
  au BufRead,BufNewFile *.tex setlocal filetype=tex formatoptions=t1 wrap spell spelllang=es_es noexpandtab linebreak smartindent synmaxcol=3000 display=lastline
  let g:vimtex_quickfix_open_on_warning=0
augroup END
" }}}

" vim_foldtext.vim {{{
augroup vim_foldtext
  autocmd!
  if has('multi_byte')
      let g:SpiffyFoldtext_format = '%c{ }  %<%f{ }═╡ %4n lines ╞═%l{ }'
  else
      let g:SpiffyFoldtext_format = '%c{ }  %<%f{ }=| %4n lines |=%l{ }'
  endif
augroup END
" }}}

" vim_netrw.vim {{{
augroup vim_netrw
  autocmd!
  let g:netrw_browsex_viewer = 'xdg-open'
augroup END
" }}}

" vim_tsuquyomi.vim {{{
augroup vim_tsuquyomi
  autocmd!
  let g:tsuquyomi_disable_default_mappings = 1
augroup END
" }}}

" Plugins -------------------------------------------------------------

" vim_plug.vim {{{
augroup vim_plug
  autocmd!
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
augroup END
" }}}

" Load plugins {{{
call plug#begin('~/.vim/plugged')

Plug 'ap/vim-css-color'
Plug 'itchyny/lightline.vim'
" Plug 'bling/vim-airline'
" Plug 'guns/vim-clojure-static'
" Plug 'joker1007/vim-ruby-heredoc-syntax'
Plug 'junegunn/vim-easy-align'
" Plug 'junegunn/vim-emoji'
Plug 'junegunn/goyo.vim'
" Plug 'ctrlpvim/ctrlp.vim'
" Plug 'FelikZ/ctrlp-py-matcher'
" Plug 'kien/rainbow_parentheses.vim'
Plug 'mustache/vim-mustache-handlebars'
Plug 'nathanaelkane/vim-indent-guides'
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
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-git'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
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
Plug 'Shougo/vimproc.vim', { 'do' : 'make' }
" Plug 'Shougo/neocomplete.vim'
if v:version > 800 && has('python3')
    Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp' " deoplete dependency.
    Plug 'roxma/vim-hug-neovim-rpc', { 'do': 'pip3 install neovim' } " deoplete dependency
    Plug 'zchee/deoplete-jedi' " Python Completion (deoplete)
endif
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
Plug 'Olical/vim-enmasse'
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
Plug 'vim-airline/vim-airline-themes'
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
Plug 'mjbrownie/swapit'
Plug 'chrisbra/vim-zsh', { 'for': 'zsh' }
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'lervag/vimtex'
" Plug 'brennier/quicktex'
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
Plug 'xtal8/traces.vim'
Plug 'chrisbra/vim_faq'
Plug 'hauleth/sad.vim'
Plug 'machakann/vim-sandwich'
Plug 'moll/vim-node'
Plug 'kopischke/vim-fetch'
if executable('ctags')
    Plug 'ludovicchabant/vim-gutentags'
endif
Plug 'vim-scripts/Spiffy-Foldtext'
Plug 'tmhedberg/matchit'
Plug 'vim-scripts/bats.vim' " Bash Test Runner
Plug 'leafgarland/typescript-vim' " Typescript syntax
Plug 'Quramy/tsuquyomi' " Typescript server
Plug 'sukima/vim-ember-imports'

call plug#end()
" }}}
