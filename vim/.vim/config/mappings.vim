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

" Paste toggle (,p) {{{
nnoremap <leader>p :set invpaste paste?<CR>
" }}}

" Edit near files {{{
nnoremap gp :e %:h
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

nnoremap <leader>bs :Buffers<CR>
nnoremap <leader>bt :enew<CR>
nnoremap <leader>bd :lclose<bar>b#<bar>bd #<CR>
nnoremap <leader>bD :bufdo bd<CR>
nnoremap <leader><leader> <c-^>

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
