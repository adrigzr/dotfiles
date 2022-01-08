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
" nnoremap <C-e> 3<C-e>
" nnoremap <C-y> 3<C-y>
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
" nnoremap <silent> <leader>v :set nolist!<CR>
" }}}

" Clear last search (,qs) {{{
nnoremap <silent> <leader>qs :noh<CR>
" map <silent> <leader>qs <Esc>:let @/ = ""<CR>
" }}}

" Paste toggle (,p) {{{
" nnoremap <leader>p :set invpaste paste?<CR>
" }}}

" Edit near files {{{
nnoremap ge :e %:h
" }}}

" Reselect pasted text {{{
nnoremap gp `[v`]
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
" nnoremap <leader>bd :lclose<bar>b#<bar>bd #<CR>
nnoremap <leader>bd :Bdelete<CR>
nnoremap <leader>bD :bufdo :Bdelete<CR>
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

" Move lines {{{
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap <c-j> <Esc>:m .+1<CR>==gi
inoremap <c-k> <Esc>:m .-2<CR>==gi
nnoremap <leader>k :m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==
" }}}

" Text Objects {{{

" "in line" {{{
xnoremap <silent> il :<c-u>normal! g_v^<cr>
onoremap <silent> il :<c-u>normal! g_v^<cr>
" }}}

" "around line" {{{
xnoremap <silent> al :<c-u>normal! $v0<cr>
onoremap <silent> al :<c-u>normal! $v0<cr>
" }}}

" "inner document" {{{
xnoremap <silent> id :<c-u>normal! G$Vgg0<cr>
onoremap <silent> id :<c-u>normal! GVgg<cr>
" }}}

" "in number" {{{
" regular expressions that match numbers (order matters .. keep '\d' last!)
" note: \+ will be appended to the end of each
let s:regNums = [ '0b[01]', '0x\x', '\d' ]

function! s:inNumber()
	" select the next number on the line
	" this can handle the following three formats (so long as s:regNums is
	" defined as it should be above this function):
	"   1. binary  (eg: "0b1010", "0b0000", etc)
	"   2. hex     (eg: "0xffff", "0x0000", "0x10af", etc)
	"   3. decimal (eg: "0", "0000", "10", "01", etc)
	" NOTE: if there is no number on the rest of the line starting at the
	"       current cursor position, then visual selection mode is ended (if
	"       called via an omap) or nothing is selected (if called via xmap)

	" need magic for this to work properly
	let l:magic = &magic
	set magic

	let l:lineNr = line('.')

	" create regex pattern matching any binary, hex, decimal number
	let l:pat = join(s:regNums, '\+\|') . '\+'

	" move cursor to end of number
	if (!search(l:pat, 'ce', l:lineNr))
		" if it fails, there was not match on the line, so return prematurely
		return
	endif

	" start visually selecting from end of number
	normal! v

	" move cursor to beginning of number
	call search(l:pat, 'cb', l:lineNr)

	" restore magic
	let &magic = l:magic
endfunction

" "in number" (next number after cursor on current line)
xnoremap <silent> in :<c-u>call <sid>inNumber()<cr>
onoremap <silent> in :<c-u>call <sid>inNumber()<cr>
" }}}

" "around number" {{{
function! s:aroundNumber()
	" select the next number on the line and any surrounding white-space;
	" this can handle the following three formats (so long as s:regNums is
	" defined as it should be above these functions):
	"   1. binary  (eg: "0b1010", "0b0000", etc)
	"   2. hex     (eg: "0xffff", "0x0000", "0x10af", etc)
	"   3. decimal (eg: "0", "0000", "10", "01", etc)
	" NOTE: if there is no number on the rest of the line starting at the
	"       current cursor position, then visual selection mode is ended (if
	"       called via an omap) or nothing is selected (if called via xmap);
	"       this is true even if on the space following a number

	" need magic for this to work properly
	let l:magic = &magic
	set magic

	let l:lineNr = line('.')

	" create regex pattern matching any binary, hex, decimal number
	let l:pat = join(s:regNums, '\+\|') . '\+'

	" move cursor to end of number
	if (!search(l:pat, 'ce', l:lineNr))
		" if it fails, there was not match on the line, so return prematurely
		return
	endif

	" move cursor to end of any trailing white-space (if there is any)
	call search('\%'.(virtcol('.')+1).'v\s*', 'ce', l:lineNr)

	" start visually selecting from end of number + potential trailing whitspace
	normal! v

	" move cursor to beginning of number
	call search(l:pat, 'cb', l:lineNr)

	" move cursor to beginning of any white-space preceding number (if any)
	call search('\s*\%'.virtcol('.').'v', 'b', l:lineNr)

	" restore magic
	let &magic = l:magic
endfunction

" "around number" (next number on line and possible surrounding white-space)
xnoremap <silent> an :<c-u>call <sid>aroundNumber()<cr>
onoremap <silent> an :<c-u>call <sid>aroundNumber()<cr>
" }}}

" "in indentation" {{{
function! s:inIndentation()
	" select all text in current indentation level excluding any empty lines
	" that precede or follow the current indentationt level;
	"
	" the current implementation is pretty fast, even for many lines since it
	" uses "search()" with "\%v" to find the unindented levels
	"
	" NOTE: if the current level of indentation is 1 (ie in virtual column 1),
	"       then the entire buffer will be selected
	"
	" WARNING: python devs have been known to become addicted to this

	" magic is needed for this
	let l:magic = &magic
	set magic

	" move to beginning of line and get virtcol (current indentation level)
	" BRAM: there is no searchpairvirtpos() ;)
	normal! ^
	let l:vCol = virtcol(getline('.') =~# '^\s*$' ? '$' : '.')

	" pattern matching anything except empty lines and lines with recorded
	" indentation level
	let l:pat = '^\(\s*\%'.l:vCol.'v\|^$\)\@!'

	" find first match (backwards & don't wrap or move cursor)
	let l:start = search(l:pat, 'bWn') + 1

	" next, find first match (forwards & don't wrap or move cursor)
	let l:end = search(l:pat, 'Wn')

	if (l:end !=# 0)
		" if search succeeded, it went too far, so subtract 1
		let l:end -= 1
	endif

	" go to start (this includes empty lines) and--importantly--column 0
	execute 'normal! '.l:start.'G0'

	" skip empty lines (unless already on one .. need to be in column 0)
	call search('^[^\n\r]', 'Wc')

	" go to end (this includes empty lines)
	execute 'normal! Vo'.l:end.'G'

	" skip backwards to last selected non-empty line
	call search('^[^\n\r]', 'bWc')

	" go to end-of-line 'cause why not
	normal! $o

	" restore magic
	let &magic = l:magic
endfunction

" "in indentation" (indentation level sans any surrounding empty lines)
xnoremap <silent> ii :<c-u>call <sid>inIndentation()<cr>
onoremap <silent> ii :<c-u>call <sid>inIndentation()<cr>
" }}}

" "around indentation" {{{
function! s:aroundIndentation()
	" select all text in the current indentation level including any emtpy
	" lines that precede or follow the current indentation level;
	"
	" the current implementation is pretty fast, even for many lines since it
	" uses "search()" with "\%v" to find the unindented levels
	"
	" NOTE: if the current level of indentation is 1 (ie in virtual column 1),
	"       then the entire buffer will be selected
	"
	" WARNING: python devs have been known to become addicted to this

	" magic is needed for this (/\v doesn't seem work)
	let l:magic = &magic
	set magic

	" move to beginning of line and get virtcol (current indentation level)
	" BRAM: there is no searchpairvirtpos() ;)
	normal! ^
	let l:vCol = virtcol(getline('.') =~# '^\s*$' ? '$' : '.')

	" pattern matching anything except empty lines and lines with recorded
	" indentation level
	let l:pat = '^\(\s*\%'.l:vCol.'v\|^$\)\@!'

	" find first match (backwards & don't wrap or move cursor)
	let l:start = search(l:pat, 'bWn') + 1

	" NOTE: if l:start is 0, then search() failed; otherwise search() succeeded
	"       and l:start does not equal line('.')
	" FORMER: l:start is 0; so, if we add 1 to l:start, then it will match
	"         everything from beginning of the buffer (if you don't like
	"         this, then you can modify the code) since this will be the
	"         equivalent of "norm! 1G" below
	" LATTER: l:start is not 0 but is also not equal to line('.'); therefore,
	"         we want to add one to l:start since it will always match one
	"         line too high if search() succeeds

	" next, find first match (forwards & don't wrap or move cursor)
	let l:end = search(l:pat, 'Wn')

	" NOTE: if l:end is 0, then search() failed; otherwise, if l:end is not
	"       equal to line('.'), then the search succeeded.
	" FORMER: l:end is 0; we want this to match until the end-of-buffer if it
	"         fails to find a match for same reason as mentioned above;
	"         again, modify code if you do not like this); therefore, keep
	"         0--see "NOTE:" below inside the if block comment
	" LATTER: l:end is not 0, so the search() must have succeeded, which means
	"         that l:end will match a different line than line('.')

	if (l:end !=# 0)
		" if l:end is 0, then the search() failed; if we subtract 1, then it
		" will effectively do "norm! -1G" which is definitely not what is
		" desired for probably every circumstance; therefore, only subtract one
		" if the search() succeeded since this means that it will match at least
		" one line too far down
		" NOTE: exec "norm! 0G" still goes to end-of-buffer just like "norm! G",
		"       so it's ok if l:end is kept as 0. As mentioned above, this means
		"       that it will match until end of buffer, but that is what I want
		"       anyway (change code if you don't want)
		let l:end -= 1
	endif

	" finally, select from l:start to l:end
	execute 'normal! '.l:start.'G0V'.l:end.'G$o'

	" restore magic
	let &magic = l:magic
endfunction

" "around indentation" (indentation level and any surrounding empty lines)
xnoremap <silent> ai :<c-u>call <sid>aroundIndentation()<cr>
onoremap <silent> ai :<c-u>call <sid>aroundIndentation()<cr>
" }}}

" }}}
