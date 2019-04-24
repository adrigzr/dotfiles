let SessionLoad = 1
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
inoremap <expr> <S-Tab> pumvisible() ? "\" : "\"
inoremap <silent> <Plug>(table-mode-tableize) |:call tablemode#TableizeInsertMode()a
inoremap <silent> <Plug>(fzf-maps-i) :call fzf#vim#maps('i', 0)
inoremap <expr> <Plug>(fzf-complete-buffer-line) fzf#vim#complete#buffer_line()
inoremap <expr> <Plug>(fzf-complete-line) fzf#vim#complete#line()
inoremap <expr> <Plug>(fzf-complete-file-ag) fzf#vim#complete#path('ag -l -g ""')
inoremap <expr> <Plug>(fzf-complete-file) fzf#vim#complete#path("find . -path '*/\.*' -prune -o -type f -print -o -type l -print | sed 's:^..::'")
inoremap <expr> <Plug>(fzf-complete-path) fzf#vim#complete#path("find . -path '*/\.*' -prune -o -print | sed '1d;s:^..::'")
inoremap <expr> <Plug>(fzf-complete-word) fzf#vim#complete#word()
inoremap <silent> <Plug>(ale_complete) :ALEComplete
inoremap <silent> <expr> <Plug>(neosnippet_start_unite_snippet) unite#sources#neosnippet#start_complete()
inoremap <silent> <expr> <Plug>(neosnippet_jump) neosnippet#mappings#jump_impl()
inoremap <silent> <expr> <Plug>(neosnippet_expand) neosnippet#mappings#expand_impl()
inoremap <silent> <expr> <Plug>(neosnippet_jump_or_expand) neosnippet#mappings#jump_or_expand_impl()
inoremap <silent> <expr> <Plug>(neosnippet_expand_or_jump) neosnippet#mappings#expand_or_jump_impl()
inoremap <Plug>(operator-sandwich-gv) gv
inoremap <Plug>(operator-sandwich-g@) g@
inoremap <silent> <SNR>89_AutoPairsReturn =AutoPairsReturn()
inoremap <silent> <Plug>_ =coc#_complete()
imap <PageDown> 
imap <PageUp> 
map! <D-v> *
nmap <silent>  <Plug>SwapIncrement
noremap <silent>  :call smooth_scroll#up(&scroll*2, 0, 4)
noremap <silent>  :call smooth_scroll#down(&scroll, 0, 2)
nnoremap  3
noremap <silent>  :call smooth_scroll#down(&scroll*2, 0, 4)
snoremap  a<BS>
nnoremap <silent>  :TmuxNavigateLeft
smap <expr> 	 neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\	"
nnoremap <silent> <NL> :TmuxNavigateDown
nnoremap <silent>  :TmuxNavigateUp
nnoremap <silent>  :TmuxNavigateRight
snoremap  a<BS>
xmap  <Plug>(EasyAlign)
nnoremap <silent>  :Files
nmap  <Plug>(RepeatRedo)
xmap  <Plug>(neosnippet_expand_target)
smap  <Plug>(neosnippet_expand_or_jump)
noremap <silent>  :call smooth_scroll#up(&scroll, 0, 2)
nmap <silent>  <Plug>SwapDecrement
nnoremap  3
noremap <silent>  :call AltScreenControlZ()
nnoremap <silent>  :TmuxNavigatePrevious
nnoremap  t :NERDTreeFind
nnoremap  gpl :Dispatch git pull
nnoremap  gps :Dispatch git push
nnoremap  go :Git checkout 
nnoremap  gb :Git branch 
nnoremap  gm :Gmove 
nnoremap  gp :Ggrep 
nnoremap  gl :silent! Glog
nnoremap  gw :Gwrite
nnoremap  gr :Gread
nnoremap  ge :Gedit
nnoremap  gd :Gdiff
nnoremap  ga :Gcommit --amend
nnoremap  gc :Dispatch git commit
nnoremap  gs :Gstatus
nmap  qf <Plug>(coc-fix-current)
nmap  ac <Plug>(coc-codeaction)
nmap  a <Plug>(coc-codeaction-selected)
vmap  a <Plug>(coc-codeaction-selected)
nmap  = <Plug>(coc-format-selected)
vmap  = <Plug>(coc-format-selected)
nmap  rn <Plug>(coc-rename)
nnoremap  e :call emberimports#run()
xmap  T <Plug>(table-mode-tableize-delimiter)
xmap  ft <Plug>(table-mode-tableize)
nmap  ft <Plug>(table-mode-tableize)
nnoremap <silent>  fm :call tablemode#Toggle()
xmap <silent>  s :StripWhitespace
nnoremap  pk :ptprevious
nnoremap  pj :ptnext
nnoremap  pq :pclose
nnoremap  ll :ll
nnoremap  lk :lprev
nnoremap  lj :lnext
nnoremap  lo :lopen
nnoremap  lq :lclose
nnoremap  qc :cc
nnoremap  qk :cprev
nnoremap  qj :cnext
nnoremap  qo :copen
nnoremap  qq :cclose
nnoremap    
nnoremap  bD :bufdo bd
nnoremap  bd :lclose|b#|bd #
nnoremap  bt :enew
nnoremap  bs :Buffers
map  dl :diffget LO
map  db :diffget BA
map  dr :diffget RE
map  dp [c
map  dn ]c
vnoremap  * "hy:%s/\Vh//<Left>
nnoremap  * :%s/\<\>//<Left>
nnoremap   o
nnoremap  p :set invpaste paste?
nnoremap <silent>  qs :noh
nnoremap   <Nop>
nnoremap <silent>  v :set nolist!
noremap  W :w !sudo tee %
noremap  w :w
xmap # <Plug>(sad-search-backward)
nnoremap <silent> '[ :call signature#mark#Goto("prev", "line", "alpha")
nnoremap <silent> '] :call signature#mark#Goto("next", "line", "alpha")
nnoremap ' `
xmap * <Plug>(sad-search-forward)
nmap . <Plug>(RepeatDot)
xnoremap // y/\V"N
nnoremap =op <Nop>
xnoremap ?? y?\V"
nnoremap J mjJg`j:delmarks j
nmap S <Plug>(sad-change-backward)
xmap S <Plug>(sad-change-backward)
nmap U <Plug>(RepeatUndoLine)
nnoremap Y y$
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nnoremap <silent> [= :call signature#marker#Goto("prev", "any",  v:count)
nnoremap <silent> [- :call signature#marker#Goto("prev", "same", v:count)
nnoremap <silent> [` :call signature#mark#Goto("prev", "spot", "pos")
nnoremap <silent> [' :call signature#mark#Goto("prev", "line", "pos")
xmap [% [%m'gv``
nmap [xx <Plug>unimpaired_line_xml_encode
xmap [x <Plug>unimpaired_xml_encode
nmap [x <Plug>unimpaired_xml_encode
nmap [uu <Plug>unimpaired_line_url_encode
xmap [u <Plug>unimpaired_url_encode
nmap [u <Plug>unimpaired_url_encode
nmap [yy <Plug>unimpaired_line_string_encode
xmap [y <Plug>unimpaired_string_encode
nmap [y <Plug>unimpaired_string_encode
nmap [P <Plug>unimpairedPutAbove
nmap [p <Plug>unimpairedPutAbove
xmap [e <Plug>unimpairedMoveSelectionUp
nmap [e <Plug>unimpairedMoveUp
nmap [  <Plug>unimpairedBlankUp
omap [n <Plug>unimpairedContextPrevious
nmap [n <Plug>unimpairedContextPrevious
nmap [f <Plug>unimpairedDirectoryPrevious
nmap [ <Plug>unimpairedTPPrevious
nmap [T <Plug>unimpairedTFirst
nmap [t <Plug>unimpairedTPrevious
nmap [ <Plug>unimpairedQPFile
nmap [Q <Plug>unimpairedQFirst
nmap [q <Plug>unimpairedQPrevious
nmap [ <Plug>unimpairedLPFile
nmap [L <Plug>unimpairedLFirst
nmap [l <Plug>unimpairedLPrevious
nmap [B <Plug>unimpairedBFirst
nmap [b <Plug>unimpairedBPrevious
nmap [A <Plug>unimpairedAFirst
nmap [a <Plug>unimpairedAPrevious
xnoremap [1;5B :'<,'>m'>+gv=`<my`>mzgv`yo`z
xnoremap [1;5A :'<,'>m'<-2gv=`>my`<mzgv`yo`z
nnoremap [1;5B mz:m+`z==
nnoremap [1;5A mz:m-2`z==
nmap <silent> ]d <Plug>(coc-diagnostic-next)
nnoremap <silent> ]= :call signature#marker#Goto("next", "any",  v:count)
nnoremap <silent> ]- :call signature#marker#Goto("next", "same", v:count)
nnoremap <silent> ]` :call signature#mark#Goto("next", "spot", "pos")
nnoremap <silent> ]' :call signature#mark#Goto("next", "line", "pos")
xmap ]% ]%m'gv``
nmap ]xx <Plug>unimpaired_line_xml_decode
xmap ]x <Plug>unimpaired_xml_decode
nmap ]x <Plug>unimpaired_xml_decode
nmap ]uu <Plug>unimpaired_line_url_decode
xmap ]u <Plug>unimpaired_url_decode
nmap ]u <Plug>unimpaired_url_decode
nmap ]yy <Plug>unimpaired_line_string_decode
xmap ]y <Plug>unimpaired_string_decode
nmap ]y <Plug>unimpaired_string_decode
nmap ]P <Plug>unimpairedPutBelow
nmap ]p <Plug>unimpairedPutBelow
xmap ]e <Plug>unimpairedMoveSelectionDown
nmap ]e <Plug>unimpairedMoveDown
nmap ]  <Plug>unimpairedBlankDown
omap ]n <Plug>unimpairedContextNext
nmap ]n <Plug>unimpairedContextNext
nmap ]f <Plug>unimpairedDirectoryNext
nmap ] <Plug>unimpairedTPNext
nmap ]T <Plug>unimpairedTLast
nmap ]t <Plug>unimpairedTNext
nmap ] <Plug>unimpairedQNFile
nmap ]Q <Plug>unimpairedQLast
nmap ]q <Plug>unimpairedQNext
nmap ] <Plug>unimpairedLNFile
nmap ]L <Plug>unimpairedLLast
nmap ]l <Plug>unimpairedLNext
nmap ]B <Plug>unimpairedBLast
nmap ]b <Plug>unimpairedBNext
nmap ]A <Plug>unimpairedALast
nmap ]a <Plug>unimpairedANext
nnoremap <silent> `[ :call signature#mark#Goto("prev", "spot", "alpha")
nnoremap <silent> `] :call signature#mark#Goto("next", "spot", "alpha")
xmap as <Plug>(textobj-sandwich-query-a)
omap as <Plug>(textobj-sandwich-query-a)
xmap ab <Plug>(textobj-sandwich-auto-a)
omap ab <Plug>(textobj-sandwich-auto-a)
xmap a% [%v]%
onoremap <silent> al :normal! $v0
xnoremap <silent> al :normal! $v0
nnoremap cop <Nop>
nmap cr <Plug>(abolish-coerce-word)
nnoremap <silent> dm :call signature#utils#Remove(v:count)
nnoremap <silent> gb :Buffers
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gm <Plug>(coc-implementation)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gd <Plug>(coc-definition)
xmap gx <Plug>NetrwBrowseXVis
nmap gx <Plug>NetrwBrowseX
xmap g! <Plug>ScripteaseFilter
nmap g! <Plug>ScripteaseFilter
xmap g= <Plug>ScripteaseFilter
nmap g= <Plug>ScripteaseFilter
xnoremap gF :call fetch#visual(v:count1)
nnoremap gF :call fetch#cfile(v:count1)
nmap gcu <Plug>Commentary<Plug>Commentary
nmap gcc <Plug>CommentaryLine
omap gc <Plug>Commentary
nmap gc <Plug>Commentary
xmap gc <Plug>Commentary
nnoremap gk k
nnoremap gj j
nnoremap gp :e %:h
xmap is <Plug>(textobj-sandwich-query-i)
omap is <Plug>(textobj-sandwich-query-i)
xmap ib <Plug>(textobj-sandwich-auto-i)
omap ib <Plug>(textobj-sandwich-auto-i)
onoremap <silent> id :normal! GVgg
xnoremap <silent> id :normal! G$Vgg0
onoremap <silent> il :normal! g_v^
xnoremap <silent> il :normal! g_v^
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'
nnoremap <silent> m/ :call signature#mark#List(0, 0)
nnoremap <silent> m<BS> :call signature#marker#Purge()
nnoremap <silent> m- :call signature#mark#Purge("line")
nnoremap <silent> m. :call signature#mark#ToggleAtLine()
nnoremap <silent> m, :call signature#mark#Toggle("next")
nnoremap <silent> m :call signature#utils#Input()
nmap sp <Plug>(sad-change-backward)
nmap sn <Plug>(sad-change-forward)
nmap <silent> srb <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)
nmap <silent> sdb <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)
nmap <silent> sr <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
nmap <silent> sd <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
xmap sr <Plug>(operator-sandwich-replace)
xmap sd <Plug>(operator-sandwich-delete)
omap sa <Plug>(operator-sandwich-g@)
xmap sa <Plug>(operator-sandwich-add)
nmap sa <Plug>(operator-sandwich-add)
nmap s <Plug>(sad-change-forward)
xmap s <Plug>(sad-change-forward)
nmap u <Plug>(RepeatUndo)
nmap zS <Plug>ScripteaseSynnames
nnoremap <silent> <Plug>(RepeatRedo) :call repeat#wrap("\<C-R>",v:count)
nnoremap <silent> <Plug>(RepeatUndoLine) :call repeat#wrap('U',v:count)
nnoremap <silent> <Plug>(RepeatUndo) :call repeat#wrap('u',v:count)
nnoremap <silent> <Plug>(RepeatDot) :exe repeat#run(v:count)
snoremap <Del> a<BS>
snoremap <BS> a<BS>
nnoremap <Plug>(-fzf-:) :
nnoremap <Plug>(-fzf-/) /
nnoremap <Plug>(-fzf-vim-do) :execute g:__fzf_command
nnoremap <SNR>153_: :=v:count ? v:count : ''
nnoremap <F9> :Dispatch
vnoremap <silent> <Plug>NetrwBrowseXVis :call netrw#BrowseXVis()
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#BrowseX(expand((exists("g:netrw_gx")? g:netrw_gx : '<cfile>')),netrw#CheckIfRemote())
nnoremap <silent> <Plug>ScripteaseSynnames :exe scriptease#synnames_map(v:count)
onoremap <SNR>105__ _
xnoremap <expr> <Plug>ScripteaseFilter scriptease#filterop()
nnoremap <expr> <Plug>ScripteaseFilter scriptease#filterop()
nnoremap <silent> <Plug>(table-mode-sort) :call tablemode#spreadsheet#Sort('')
nnoremap <silent> <Plug>(table-mode-eval-formula) :call tablemode#spreadsheet#formula#EvaluateFormulaLine()
nnoremap <silent> <Plug>(table-mode-add-formula) :call tablemode#spreadsheet#formula#Add()
nnoremap <silent> <Plug>(table-mode-delete-column) :call tablemode#spreadsheet#DeleteColumn()
nnoremap <silent> <Plug>(table-mode-delete-row) :call tablemode#spreadsheet#DeleteRow()
xnoremap <silent> <Plug>(table-mode-cell-text-object-i) :call tablemode#spreadsheet#cell#TextObject(1)
xnoremap <silent> <Plug>(table-mode-cell-text-object-a) :call tablemode#spreadsheet#cell#TextObject(0)
onoremap <silent> <Plug>(table-mode-cell-text-object-i) :call tablemode#spreadsheet#cell#TextObject(1)
onoremap <silent> <Plug>(table-mode-cell-text-object-a) :call tablemode#spreadsheet#cell#TextObject(0)
nnoremap <silent> <Plug>(table-mode-motion-right) :call tablemode#spreadsheet#cell#Motion('l')
nnoremap <silent> <Plug>(table-mode-motion-left) :call tablemode#spreadsheet#cell#Motion('h')
nnoremap <silent> <Plug>(table-mode-motion-down) :call tablemode#spreadsheet#cell#Motion('j')
nnoremap <silent> <Plug>(table-mode-motion-up) :call tablemode#spreadsheet#cell#Motion('k')
nnoremap <silent> <Plug>(table-mode-realign) :call tablemode#table#Realign('.')
xnoremap <silent> <Plug>(table-mode-tableize-delimiter) :call tablemode#TableizeByDelimiter()
xnoremap <silent> <Plug>(table-mode-tableize) :Tableize
nnoremap <silent> <Plug>(table-mode-tableize) :Tableize
onoremap <silent> <Plug>(fzf-maps-o) :call fzf#vim#maps('o', 0)
xnoremap <silent> <Plug>(fzf-maps-x) :call fzf#vim#maps('x', 0)
nnoremap <silent> <Plug>(fzf-maps-n) :call fzf#vim#maps('n', 0)
nnoremap <silent> <Plug>(ale_documentation) :ALEDocumentation
nnoremap <silent> <Plug>(ale_hover) :ALEHover
nnoremap <silent> <Plug>(ale_find_references) :ALEFindReferences
nnoremap <silent> <Plug>(ale_go_to_type_definition_in_vsplit) :ALEGoToTypeDefinitionInVSplit
nnoremap <silent> <Plug>(ale_go_to_type_definition_in_split) :ALEGoToTypeDefinitionInSplit
nnoremap <silent> <Plug>(ale_go_to_type_definition_in_tab) :ALEGoToTypeDefinitionInTab
nnoremap <silent> <Plug>(ale_go_to_type_definition) :ALEGoToTypeDefinition
nnoremap <silent> <Plug>(ale_go_to_definition_in_vsplit) :ALEGoToDefinitionInVSplit
nnoremap <silent> <Plug>(ale_go_to_definition_in_split) :ALEGoToDefinitionInSplit
nnoremap <silent> <Plug>(ale_go_to_definition_in_tab) :ALEGoToDefinitionInTab
nnoremap <silent> <Plug>(ale_go_to_definition) :ALEGoToDefinition
nnoremap <silent> <Plug>(ale_fix) :ALEFix
nnoremap <silent> <Plug>(ale_detail) :ALEDetail
nnoremap <silent> <Plug>(ale_lint) :ALELint
nnoremap <silent> <Plug>(ale_reset_buffer) :ALEResetBuffer
nnoremap <silent> <Plug>(ale_disable_buffer) :ALEDisableBuffer
nnoremap <silent> <Plug>(ale_enable_buffer) :ALEEnableBuffer
nnoremap <silent> <Plug>(ale_toggle_buffer) :ALEToggleBuffer
nnoremap <silent> <Plug>(ale_reset) :ALEReset
nnoremap <silent> <Plug>(ale_disable) :ALEDisable
nnoremap <silent> <Plug>(ale_enable) :ALEEnable
nnoremap <silent> <Plug>(ale_toggle) :ALEToggle
nnoremap <silent> <Plug>(ale_last) :ALELast
nnoremap <silent> <Plug>(ale_first) :ALEFirst
nnoremap <silent> <Plug>(ale_next_wrap_warning) :ALENext -wrap -warning
nnoremap <silent> <Plug>(ale_next_warning) :ALENext -warning
nnoremap <silent> <Plug>(ale_next_wrap_error) :ALENext -wrap -error
nnoremap <silent> <Plug>(ale_next_error) :ALENext -error
nnoremap <silent> <Plug>(ale_next_wrap) :ALENextWrap
nnoremap <silent> <Plug>(ale_next) :ALENext
nnoremap <silent> <Plug>(ale_previous_wrap_warning) :ALEPrevious -wrap -warning
nnoremap <silent> <Plug>(ale_previous_warning) :ALEPrevious -warning
nnoremap <silent> <Plug>(ale_previous_wrap_error) :ALEPrevious -wrap -error
nnoremap <silent> <Plug>(ale_previous_error) :ALEPrevious -error
nnoremap <silent> <Plug>(ale_previous_wrap) :ALEPreviousWrap
nnoremap <silent> <Plug>(ale_previous) :ALEPrevious
xnoremap <silent> <Plug>(neosnippet_register_oneshot_snippet) :call neosnippet#mappings#_register_oneshot_snippet()
xnoremap <silent> <Plug>(neosnippet_expand_target) :call neosnippet#mappings#_expand_target()
xnoremap <silent> <Plug>(neosnippet_get_selected_text) :call neosnippet#helpers#get_selected_text(visualmode(), 1)
snoremap <silent> <expr> <Plug>(neosnippet_jump) neosnippet#mappings#jump_impl()
snoremap <silent> <expr> <Plug>(neosnippet_expand) neosnippet#mappings#expand_impl()
snoremap <silent> <expr> <Plug>(neosnippet_jump_or_expand) neosnippet#mappings#jump_or_expand_impl()
snoremap <silent> <expr> <Plug>(neosnippet_expand_or_jump) neosnippet#mappings#expand_or_jump_impl()
noremap <Plug>(sandwich-nop) <Nop>
xnoremap <silent> <expr> <Plug>(textobj-sandwich-literal-query-a) textobj#sandwich#query('x', 'a', {}, [])
onoremap <silent> <expr> <Plug>(textobj-sandwich-literal-query-a) textobj#sandwich#query('o', 'a', {}, [])
nnoremap <silent> <expr> <Plug>(textobj-sandwich-literal-query-a) textobj#sandwich#query('n', 'a', {}, [])
xnoremap <silent> <expr> <Plug>(textobj-sandwich-literal-query-i) textobj#sandwich#query('x', 'i', {}, [])
onoremap <silent> <expr> <Plug>(textobj-sandwich-literal-query-i) textobj#sandwich#query('o', 'i', {}, [])
nnoremap <silent> <expr> <Plug>(textobj-sandwich-literal-query-i) textobj#sandwich#query('n', 'i', {}, [])
xnoremap <silent> <expr> <Plug>(textobj-sandwich-query-a) textobj#sandwich#query('x', 'a')
onoremap <silent> <expr> <Plug>(textobj-sandwich-query-a) textobj#sandwich#query('o', 'a')
nnoremap <silent> <expr> <Plug>(textobj-sandwich-query-a) textobj#sandwich#query('n', 'a')
xnoremap <silent> <expr> <Plug>(textobj-sandwich-query-i) textobj#sandwich#query('x', 'i')
onoremap <silent> <expr> <Plug>(textobj-sandwich-query-i) textobj#sandwich#query('o', 'i')
nnoremap <silent> <expr> <Plug>(textobj-sandwich-query-i) textobj#sandwich#query('n', 'i')
xnoremap <silent> <expr> <Plug>(textobj-sandwich-auto-a) textobj#sandwich#auto('x', 'a')
onoremap <silent> <expr> <Plug>(textobj-sandwich-auto-a) textobj#sandwich#auto('o', 'a')
nnoremap <silent> <expr> <Plug>(textobj-sandwich-auto-a) textobj#sandwich#auto('n', 'a')
xnoremap <silent> <expr> <Plug>(textobj-sandwich-auto-i) textobj#sandwich#auto('x', 'i')
onoremap <silent> <expr> <Plug>(textobj-sandwich-auto-i) textobj#sandwich#auto('o', 'i')
nnoremap <silent> <expr> <Plug>(textobj-sandwich-auto-i) textobj#sandwich#auto('n', 'i')
xnoremap <silent> <Plug>(textobj-sandwich-tag-a) :call sandwich#magicchar#t#at()
xnoremap <silent> <Plug>(textobj-sandwich-tag-i) :call sandwich#magicchar#t#it()
onoremap <silent> <Plug>(textobj-sandwich-tag-a) :call sandwich#magicchar#t#at()
onoremap <silent> <Plug>(textobj-sandwich-tag-i) :call sandwich#magicchar#t#it()
xnoremap <silent> <Plug>(textobj-sandwich-tagname-a) :call sandwich#magicchar#t#a()
xnoremap <silent> <Plug>(textobj-sandwich-tagname-i) :call sandwich#magicchar#t#i()
onoremap <silent> <Plug>(textobj-sandwich-tagname-a) :call sandwich#magicchar#t#a()
onoremap <silent> <Plug>(textobj-sandwich-tagname-i) :call sandwich#magicchar#t#i()
xnoremap <silent> <Plug>(textobj-sandwich-function-a) :call sandwich#magicchar#f#a()
xnoremap <silent> <Plug>(textobj-sandwich-function-ap) :call sandwich#magicchar#f#ap()
onoremap <silent> <Plug>(textobj-sandwich-function-a) :call sandwich#magicchar#f#a()
onoremap <silent> <Plug>(textobj-sandwich-function-ap) :call sandwich#magicchar#f#ap()
xnoremap <silent> <Plug>(textobj-sandwich-function-i) :call sandwich#magicchar#f#i()
xnoremap <silent> <Plug>(textobj-sandwich-function-ip) :call sandwich#magicchar#f#ip()
onoremap <silent> <Plug>(textobj-sandwich-function-i) :call sandwich#magicchar#f#i()
onoremap <silent> <Plug>(textobj-sandwich-function-ip) :call sandwich#magicchar#f#ip()
nnoremap <Plug>(sandwich-CTRL-v) 
nnoremap <Plug>(sandwich-V) V
nnoremap <Plug>(sandwich-v) v
nnoremap <Plug>(sandwich-O) O
nnoremap <Plug>(sandwich-o) o
nnoremap <Plug>(sandwich-i) i
nnoremap <Plug>(operator-sandwich-gv) gv
noremap <Plug>(operator-sandwich-g@) g@
noremap <silent> <Plug>(operator-sandwich-replace-visualrepeat) :call operator#sandwich#visualrepeat('replace')
noremap <silent> <Plug>(operator-sandwich-delete-visualrepeat) :call operator#sandwich#visualrepeat('delete')
noremap <silent> <Plug>(operator-sandwich-add-visualrepeat) :call operator#sandwich#visualrepeat('add')
nnoremap <silent> <expr> <Plug>(operator-sandwich-dot) operator#sandwich#dot()
nnoremap <silent> <expr> <Plug>(operator-sandwich-predot) operator#sandwich#predot()
onoremap <silent> <expr> <Plug>(operator-sandwich-squash-count) operator#sandwich#squash_count()
onoremap <silent> <expr> <Plug>(operator-sandwich-release-count) operator#sandwich#release_count()
onoremap <silent> <expr> <Plug>(operator-sandwich-synchro-count) operator#sandwich#synchro_count()
xnoremap <silent> <Plug>(operator-sandwich-replace-query1st) :call operator#sandwich#query1st('replace', 'x')
nnoremap <silent> <Plug>(operator-sandwich-replace-query1st) :call operator#sandwich#query1st('replace', 'n')
xnoremap <silent> <Plug>(operator-sandwich-add-query1st) :call operator#sandwich#query1st('add', 'x')
nnoremap <silent> <Plug>(operator-sandwich-add-query1st) :call operator#sandwich#query1st('add', 'n')
xnoremap <silent> <Plug>(operator-sandwich-replace-pre) :call operator#sandwich#prerequisite('replace', 'x')
nnoremap <silent> <Plug>(operator-sandwich-replace-pre) :call operator#sandwich#prerequisite('replace', 'n')
xnoremap <silent> <Plug>(operator-sandwich-delete-pre) :call operator#sandwich#prerequisite('delete', 'x')
nnoremap <silent> <Plug>(operator-sandwich-delete-pre) :call operator#sandwich#prerequisite('delete', 'n')
xnoremap <silent> <Plug>(operator-sandwich-add-pre) :call operator#sandwich#prerequisite('add', 'x')
nnoremap <silent> <Plug>(operator-sandwich-add-pre) :call operator#sandwich#prerequisite('add', 'n')
omap <silent> <Plug>(operator-sandwich-replace) <Plug>(operator-sandwich-g@)
xmap <silent> <Plug>(operator-sandwich-replace) <Plug>(operator-sandwich-replace-pre)<Plug>(operator-sandwich-gv)<Plug>(operator-sandwich-g@)
nmap <silent> <Plug>(operator-sandwich-replace) <Plug>(operator-sandwich-replace-pre)<Plug>(operator-sandwich-g@)
omap <silent> <Plug>(operator-sandwich-delete) <Plug>(operator-sandwich-g@)
xmap <silent> <Plug>(operator-sandwich-delete) <Plug>(operator-sandwich-delete-pre)<Plug>(operator-sandwich-gv)<Plug>(operator-sandwich-g@)
nmap <silent> <Plug>(operator-sandwich-delete) <Plug>(operator-sandwich-delete-pre)<Plug>(operator-sandwich-g@)
omap <silent> <Plug>(operator-sandwich-add) <Plug>(operator-sandwich-g@)
xmap <silent> <Plug>(operator-sandwich-add) <Plug>(operator-sandwich-add-pre)<Plug>(operator-sandwich-gv)<Plug>(operator-sandwich-g@)
nmap <silent> <Plug>(operator-sandwich-add) <Plug>(operator-sandwich-add-pre)<Plug>(operator-sandwich-g@)
nnoremap <Plug>(coc-fix-current) :call CocActionAsync('doQuickfix')
nnoremap <Plug>(coc-openlink) :call CocActionAsync('openLink')
nnoremap <Plug>(coc-references) :call CocActionAsync('jumpReferences')
nnoremap <Plug>(coc-type-definition) :call CocActionAsync('jumpTypeDefinition')
nnoremap <Plug>(coc-implementation) :call CocActionAsync('jumpImplementation')
nnoremap <Plug>(coc-declaration) :call CocActionAsync('jumpDeclaration')
nnoremap <Plug>(coc-definition) :call CocActionAsync('jumpDefinition')
nnoremap <Plug>(coc-diagnostic-prev) :call CocActionAsync('diagnosticPrevious')
nnoremap <Plug>(coc-diagnostic-next) :call CocActionAsync('diagnosticNext')
nnoremap <Plug>(coc-diagnostic-info) :call CocActionAsync('diagnosticInfo')
nnoremap <Plug>(coc-format) :call CocActionAsync('format')
nnoremap <Plug>(coc-rename) :call CocActionAsync('rename')
nnoremap <Plug>(coc-codeaction) :call CocActionAsync('codeAction',     '')
vnoremap <Plug>(coc-codeaction-selected) :call CocActionAsync('codeAction',     visualmode())
vnoremap <Plug>(coc-format-selected) :call CocActionAsync('formatSelected', visualmode())
nnoremap <Plug>(coc-codelens-action) :call CocActionAsync('codeLensAction')
nnoremap <silent> <Plug>GitGutterPreviewHunk :GitGutterPreviewHunk
nnoremap <silent> <Plug>GitGutterUndoHunk :GitGutterUndoHunk
nnoremap <silent> <Plug>GitGutterStageHunk :GitGutterStageHunk
nnoremap <silent> <expr> <Plug>GitGutterPrevHunk &diff ? '[c' : ":\execute v:count1 . 'GitGutterPrevHunk'\"
nnoremap <silent> <expr> <Plug>GitGutterNextHunk &diff ? ']c' : ":\execute v:count1 . 'GitGutterNextHunk'\"
xnoremap <silent> <Plug>GitGutterTextObjectOuterVisual :call gitgutter#hunk#text_object(0)
xnoremap <silent> <Plug>GitGutterTextObjectInnerVisual :call gitgutter#hunk#text_object(1)
onoremap <silent> <Plug>GitGutterTextObjectOuterPending :call gitgutter#hunk#text_object(0)
onoremap <silent> <Plug>GitGutterTextObjectInnerPending :call gitgutter#hunk#text_object(1)
nmap <expr> <Plug>(sad-change-backward-linewise) '0"'.v:register.'<Plug>(sad-change-backward)'.v:count1.'g_'
nmap <expr> <Plug>(sad-change-forward-linewise) '0"'.v:register.'<Plug>(sad-change-forward)'.v:count1.'g_'
nnoremap <silent> <expr> <Plug>(sad-change-backward) ':set opfunc=sad#search_and_replace_backward"'.v:register.'g@'
nnoremap <silent> <expr> <Plug>(sad-change-forward) ':set opfunc=sad#search_and_replace_forward"'.v:register.'g@'
xnoremap <silent> <Plug>(sad-change-backward) :call sad#search_and_replace_backward(visualmode(), 1)
xnoremap <silent> <Plug>(sad-change-forward) :call sad#search_and_replace_forward(visualmode(), 1)
nnoremap <silent> <Plug>(sad-search-backward) :set opfunc=sad#search_backwardg@
nnoremap <silent> <Plug>(sad-search-forward) :set opfunc=sad#search_forwardg@
xnoremap <silent> <Plug>(sad-search-backward) :call sad#search_backward(visualmode(), 1)
xnoremap <silent> <Plug>(sad-search-forward) :call sad#search_forward(visualmode(), 1)
nnoremap <silent> <Plug>(sad-enable-hlsearch) :let v:hlsearch=1
nnoremap <silent> <Plug>SwapDecrement :let swap_count = v:count|call SwapWord(expand("<cword>"), swap_count, 'backward','no')|silent! call repeat#set("\<Plug>SwapDecrement", swap_count)|unlet swap_count
nnoremap <silent> <Plug>SwapIncrement :let swap_count = v:count|call SwapWord(expand("<cword>"), swap_count, 'forward', 'no')|silent! call repeat#set("\<Plug>SwapIncrement", swap_count)|unlet swap_count
nnoremap <Plug>SwapItFallbackDecrement 
nnoremap <Plug>SwapItFallbackIncrement 
nnoremap <silent> <Plug>(startify-open-buffers) :call startify#open_buffers()
nnoremap <silent> <Plug>unimpairedTPNext :exe "p".(v:count ? v:count : "")."tnext"
nnoremap <silent> <Plug>unimpairedTPPrevious :exe "p".(v:count ? v:count : "")."tprevious"
nnoremap <silent> <Plug>unimpairedTLast :exe "".(v:count ? v:count : "")."tlast"
nnoremap <silent> <Plug>unimpairedTFirst :exe "".(v:count ? v:count : "")."tfirst"
nnoremap <silent> <Plug>unimpairedTNext :exe "".(v:count ? v:count : "")."tnext"
nnoremap <silent> <Plug>unimpairedTPrevious :exe "".(v:count ? v:count : "")."tprevious"
nnoremap <silent> <Plug>unimpairedQNFile :exe "".(v:count ? v:count : "")."cnfile"zv
nnoremap <silent> <Plug>unimpairedQPFile :exe "".(v:count ? v:count : "")."cpfile"zv
nnoremap <silent> <Plug>unimpairedQLast :exe "".(v:count ? v:count : "")."clast"zv
nnoremap <silent> <Plug>unimpairedQFirst :exe "".(v:count ? v:count : "")."cfirst"zv
nnoremap <silent> <Plug>unimpairedQNext :exe "".(v:count ? v:count : "")."cnext"zv
nnoremap <silent> <Plug>unimpairedQPrevious :exe "".(v:count ? v:count : "")."cprevious"zv
nnoremap <silent> <Plug>unimpairedLNFile :exe "".(v:count ? v:count : "")."lnfile"zv
nnoremap <silent> <Plug>unimpairedLPFile :exe "".(v:count ? v:count : "")."lpfile"zv
nnoremap <silent> <Plug>unimpairedLLast :exe "".(v:count ? v:count : "")."llast"zv
nnoremap <silent> <Plug>unimpairedLFirst :exe "".(v:count ? v:count : "")."lfirst"zv
nnoremap <silent> <Plug>unimpairedLNext :exe "".(v:count ? v:count : "")."lnext"zv
nnoremap <silent> <Plug>unimpairedLPrevious :exe "".(v:count ? v:count : "")."lprevious"zv
nnoremap <silent> <Plug>unimpairedBLast :exe "".(v:count ? v:count : "")."blast"
nnoremap <silent> <Plug>unimpairedBFirst :exe "".(v:count ? v:count : "")."bfirst"
nnoremap <silent> <Plug>unimpairedBNext :exe "".(v:count ? v:count : "")."bnext"
nnoremap <silent> <Plug>unimpairedBPrevious :exe "".(v:count ? v:count : "")."bprevious"
nnoremap <silent> <Plug>unimpairedALast :exe "".(v:count ? v:count : "")."last"
nnoremap <silent> <Plug>unimpairedAFirst :exe "".(v:count ? v:count : "")."first"
nnoremap <silent> <Plug>unimpairedANext :exe "".(v:count ? v:count : "")."next"
nnoremap <silent> <Plug>unimpairedAPrevious :exe "".(v:count ? v:count : "")."previous"
nmap <silent> <Plug>CommentaryUndo :echoerr "Change your <Plug>CommentaryUndo map to <Plug>Commentary<Plug>Commentary"
nnoremap <Plug>(Pulse) pulse#Pulse()
map <PageDown> 
map <PageUp> 
nnoremap <Right> <Nop>
nnoremap <Left> <Nop>
nnoremap <Down> <Nop>
nnoremap <Up> <Nop>
xmap <BS> "-d
vmap <D-x> "*d
vmap <D-c> "*y
vmap <D-v> "-d"*P
nmap <D-v> "*P
inoremap <expr> <NL> pumvisible() ? "\" : "\<NL>"
inoremap <expr>  pumvisible() ? "\" : "\"
cnoremap <expr>  traces#check_b() ? "\\=traces#get_pfile()\" : "\\\"
cnoremap <expr>  traces#check_b() ? "\\=traces#get_cfile()\" : "\\\"
cnoremap <expr>  traces#check_b() ? "\\=traces#get_cWORD()\" : "\\\"
cnoremap <expr>  traces#check_b() ? "\\=traces#get_cword()\" : "\\\"
cnoremap <expr>  traces#check_b() ? "\\=traces#get_pfile()\" : "\\\"
cnoremap <expr>  traces#check_b() ? "\\=traces#get_cfile()\" : "\\\"
cnoremap <expr>  traces#check_b() ? "\\=traces#get_cWORD()\" : "\\\"
cnoremap <expr>  traces#check_b() ? "\\=traces#get_cword()\" : "\\\"
cnoremap <expr>  traces#check_b() ? traces#get_pfile() : "\\"
cnoremap <expr>  traces#check_b() ? traces#get_cfile() : "\\"
cnoremap <expr>  traces#check_b() ? traces#get_cWORD() : "\\"
cnoremap <expr>  traces#check_b() ? traces#get_cword() : "\\"
imap  <Plug>(neosnippet_expand_or_jump)
inoremap <silent> <expr>  coc#refresh()
inoremap [1;5B :m+==gi
inoremap [1;5A :m-2==gi
let &cpo=s:cpo_save
unlet s:cpo_save
set autoindent
set background=dark
set backspace=indent,eol,start
set backupdir=~/.vim/backups
set completeopt=menu,preview,noinsert
set diffopt=filler,iwhite,internal,indent-heuristic,algorithm:patience
set directory=~/.vim/swaps
set display=lastline
set fileencodings=ucs-bom,utf-8,default,latin1
set fillchars=fold:-
set formatoptions=croqn2l1j
set gdefault
set grepformat=%f:%l:%c:%m,%f:%l:%m
set grepprg=rg\ --no-heading\ --vimgrep\ --smart-case\ --color=never\ --ignore-case\ --hidden
set helplang=en
set hidden
set history=1000
set hlsearch
set ignorecase
set incsearch
set infercase
set isfname=@,48-57,/,.,-,_,+,,,#,$,%,~,=,@-@
set nojoinspaces
set laststatus=2
set lazyredraw
set lispwords=defun,define,defmacro,set!,lambda,if,case,let,flet,let*,letrec,do,do*,define-syntax,let-syntax,letrec-syntax,destructuring-bind,defpackage,defparameter,defstruct,deftype,defvar,do-all-symbols,do-external-symbols,do-symbols,dolist,dotimes,ecase,etypecase,eval-when,labels,macrolet,multiple-value-bind,multiple-value-call,multiple-value-prog1,multiple-value-setq,prog1,progv,typecase,unless,unwind-protect,when,with-input-from-string,with-open-file,with-open-stream,with-output-to-string,with-package-iterator,define-condition,handler-bind,handler-case,restart-bind,restart-case,with-simple-restart,store-value,use-value,muffle-warning,abort,continue,with-slots,with-slots*,with-accessors,with-accessors*,defclass,defmethod,print-unreadable-object,defroutes,defpartial,defpage,defaction,deffilter,defview,defsection,describe,it
set listchars=tab:¦\ ,trail:·,eol:¬,nbsp:_
set mouse=a
set omnifunc=syntaxcomplete#Complete
set operatorfunc=operator#sandwich#delete
set regexpengine=1
set report=0
set ruler
set runtimepath=
set runtimepath+=~/.vim
set runtimepath+=~/.vim/plugged/vim-colors-solarized/
set runtimepath+=~/.vim/plugged/lightline.vim/
set runtimepath+=~/.vim/plugged/vim-SpellCheck/
set runtimepath+=~/.vim/plugged/vim-ingo-library/
set runtimepath+=~/.vim/plugged/goyo.vim/
set runtimepath+=~/.vim/plugged/FlyGrep.vim/
set runtimepath+=~/.vim/plugged/vim-polyglot/
set runtimepath+=~/.vim/plugged/vim-markdown/
set runtimepath+=~/.vim/plugged/vim-ember-hbs/
set runtimepath+=~/.vim/plugged/vim-zsh/
set runtimepath+=~/.vim/plugged/bats.vim/
set runtimepath+=~/.vim/plugged/nerdtree/
set runtimepath+=~/.vim/plugged/vim-commentary/
set runtimepath+=~/.vim/plugged/vim-repeat/
set runtimepath+=~/.vim/plugged/vim-abolish/
set runtimepath+=~/.vim/plugged/vim-sleuth/
set runtimepath+=~/.vim/plugged/vim-unimpaired/
set runtimepath+=~/.vim/plugged/vim-startify/
set runtimepath+=~/.vim/plugged/vim-altscreen/
set runtimepath+=~/.vim/plugged/swapit/
set runtimepath+=~/.vim/plugged/traces.vim/
set runtimepath+=~/.vim/plugged/sad.vim/
set runtimepath+=~/.vim/plugged/vim-fetch/
set runtimepath+=~/.vim/plugged/Spiffy-Foldtext/
set runtimepath+=~/.vim/plugged/matchit/
set runtimepath+=~/.vim/plugged/vim-css-color/
set runtimepath+=~/.vim/plugged/vim-easy-align/
set runtimepath+=~/.vim/plugged/vim-dispatch/
set runtimepath+=~/.vim/plugged/vim-git/
set runtimepath+=~/.vim/plugged/vim-fugitive/
set runtimepath+=~/.vim/plugged/vim-gitgutter/
set runtimepath+=~/.vim/plugged/vim-misc/
set runtimepath+=~/.vim/plugged/vim-notes/
set runtimepath+=~/.vim/plugged/editorconfig-vim/
set runtimepath+=~/.vim/plugged/vim-better-whitespace/
set runtimepath+=~/.vim/plugged/neco-syntax/
set runtimepath+=~/.vim/plugged/coc-neco/
set runtimepath+=~/.vim/plugged/coc.nvim/
set runtimepath+=~/.vim/plugged/auto-pairs/
set runtimepath+=~/.vim/plugged/vim-sandwich/
set runtimepath+=~/.vim/plugged/neosnippet/
set runtimepath+=~/.vim/plugged/neosnippet-snippets/
set runtimepath+=~/.vim/plugged/vim-snippets/
set runtimepath+=~/.vim/plugged/snipmate-snippets/
set runtimepath+=~/.vim/plugged/ale/
set runtimepath+=~/.vim/plugged/codi.vim/
set runtimepath+=~/.vim/plugged/vim-tmux-navigator/
set runtimepath+=~/.vim/plugged/vim-smooth-scroll/
set runtimepath+=~/.fzf/
set runtimepath+=~/.vim/plugged/fzf.vim/
set runtimepath+=~/.vim/plugged/vimtex/
set runtimepath+=~/.vim/plugged/vim-table-mode/
set runtimepath+=~/.vim/plugged/vim-markdown-preview/
set runtimepath+=~/.vim/plugged/vim-signature/
set runtimepath+=~/.vim/plugged/vim_faq/
set runtimepath+=~/.vim/plugged/vim-scriptease/
set runtimepath+=~/.vim/plugged/vim-node/
set runtimepath+=~/.vim/plugged/vim-racer/
set runtimepath+=~/.vim/plugged/vim-ember-imports/
set runtimepath+=~/.vim/plugged/wmgraphviz.vim/
set runtimepath+=~/.vim/plugged/vader.vim/
set runtimepath+=~/.config/yarn/global/node_modules/vim-node-rpc
set runtimepath+=/usr/local/share/vim/vimfiles
set runtimepath+=/usr/local/share/vim/vim81
set runtimepath+=/usr/local/share/vim/vimfiles/after
set runtimepath+=~/.vim/plugged/vim-polyglot/after
set runtimepath+=~/.vim/plugged/bats.vim/after
set runtimepath+=~/.vim/plugged/swapit/after
set runtimepath+=~/.vim/plugged/Spiffy-Foldtext/after
set runtimepath+=~/.vim/plugged/vim-css-color/after
set runtimepath+=~/.vim/plugged/vim-sandwich/after
set runtimepath+=~/.vim/plugged/vimtex/after
set runtimepath+=~/.vim/plugged/vim-signature/after
set runtimepath+=~/.vim/after
set scrolloff=6
set shell=/bin/sh
set shiftwidth=4
set shortmess=atIc
set showbreak=⤷
set noshowmode
set sidescrolloff=3
set smartcase
set smarttab
set softtabstop=2
set splitbelow
set splitright
set nostartofline
set suffixes=.bak,~,.swp,.swo,.o,.d,.info,.aux,.log,.dvi,.pdf,.bin,.bbl,.blg,.brf,.cb,.dmg,.exe,.ind,.idx,.ilg,.inx,.out,.toc,.pyc,.pyd,.dll
set noswapfile
set synmaxcol=400
set tabline=%!lightline#tabline()
set tags=./tags,tags,.tags/tags
set title
set ttimeout
set ttimeoutlen=10
set undodir=~/.vim/undo
set undofile
set viminfo='9999,s512,n~/.vim/viminfo
set visualbell
set wildignore=.DS_Store,*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js,*/smarty/*,*/.sass-cache/*,*/log/*,*/tmp/*,*/build/*,*/ckeditor/*,*/doc/*,*/source_maps/*,*/dist/*,*/recs/*
set wildignorecase
set wildmenu
set wildmode=list:longest,full
set winminheight=0
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/dotfiles/vim/.vim/plugged/coc.nvim
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
argglobal
%argdel
set stal=2
tabnew
tabrewind
edit ~/Repositories/woody-html/html/lib/ember-bbva-components/addon/pods/components/compositions/composition-carousel-loop/component.js
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe '1resize ' . ((&lines * 35 + 36) / 73)
exe 'vert 1resize ' . ((&columns * 119 + 119) / 239)
exe '2resize ' . ((&lines * 34 + 36) / 73)
exe 'vert 2resize ' . ((&columns * 119 + 119) / 239)
exe '3resize ' . ((&lines * 35 + 36) / 73)
exe 'vert 3resize ' . ((&columns * 119 + 119) / 239)
exe '4resize ' . ((&lines * 34 + 36) / 73)
exe 'vert 4resize ' . ((&columns * 119 + 119) / 239)
argglobal
let s:cpo_save=&cpo
set cpo&vim
inoremap <buffer> <silent> <BS> =AutoPairsDelete()
nmap <buffer> gf <Plug>NodeTabGotoFile
nmap <buffer>  <Plug>NodeSplitGotoFile
nmap <buffer> f <Plug>NodeSplitGotoFile
nmap <buffer>  hp <Plug>GitGutterPreviewHunk
nmap <buffer>  hu <Plug>GitGutterUndoHunk
nmap <buffer>  hs <Plug>GitGutterStageHunk
inoremap <buffer> <silent> § =AutoPairsMoveCharacter('''')
inoremap <buffer> <silent> ¢ =AutoPairsMoveCharacter('"')
inoremap <buffer> <silent> © =AutoPairsMoveCharacter(')')
inoremap <buffer> <silent> ¨ =AutoPairsMoveCharacter('(')
inoremap <buffer> <silent> î :call AutoPairsJump()a
inoremap <buffer> <silent> <expr> ð AutoPairsToggle()
inoremap <buffer> <silent> å =AutoPairsFastWrap()
inoremap <buffer> <silent> ý =AutoPairsMoveCharacter('}')
inoremap <buffer> <silent> û =AutoPairsMoveCharacter('{')
inoremap <buffer> <silent> Ý =AutoPairsMoveCharacter(']')
inoremap <buffer> <silent> Û =AutoPairsMoveCharacter('[')
nmap <buffer> [c <Plug>GitGutterPrevHunk
nmap <buffer> ]c <Plug>GitGutterNextHunk
xmap <buffer> ac <Plug>GitGutterTextObjectOuterVisual
omap <buffer> ac <Plug>GitGutterTextObjectOuterPending
nmap <buffer> gf <Plug>NodeGotoFile
xmap <buffer> ic <Plug>GitGutterTextObjectInnerVisual
omap <buffer> ic <Plug>GitGutterTextObjectInnerPending
inoremap <buffer> <silent>  =AutoPairsBackInsert()
inoremap <buffer> <silent>  =AutoPairsDelete()
inoremap <buffer> <silent>   =AutoPairsSpace()
inoremap <buffer> <silent> " =AutoPairsInsert('"')
inoremap <buffer> <silent> ' =AutoPairsInsert('''')
inoremap <buffer> <silent> ( =AutoPairsInsert('(')
inoremap <buffer> <silent> ) =AutoPairsInsert(')')
nnoremap <buffer> <silent> î :call AutoPairsJump()
xnoremap <buffer> <silent> î :call AutoPairsJump()
onoremap <buffer> <silent> î :call AutoPairsJump()
nnoremap <buffer> <silent> ð :call AutoPairsToggle()
xnoremap <buffer> <silent> ð :call AutoPairsToggle()
onoremap <buffer> <silent> ð :call AutoPairsToggle()
inoremap <buffer> <silent> [ =AutoPairsInsert('[')
inoremap <buffer> <silent> ] =AutoPairsInsert(']')
inoremap <buffer> <silent> ` =AutoPairsInsert('`')
inoremap <buffer> <silent> { =AutoPairsInsert('{')
inoremap <buffer> <silent> } =AutoPairsInsert('}')
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal backupcopy=
setlocal balloonexpr=
setlocal nobinary
set breakindent
setlocal breakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://
setlocal commentstring=//%s
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
setlocal conceallevel=0
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
set cursorline
setlocal cursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal noexpandtab
if &filetype != 'javascript'
setlocal filetype=javascript
endif
setlocal fixendofline
setlocal foldcolumn=0
setlocal nofoldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
set foldmethod=syntax
setlocal foldmethod=syntax
set foldminlines=0
setlocal foldminlines=0
set foldnestmax=10
setlocal foldnestmax=10
set foldtext=spiffy_foldtext#SpiffyFoldText()
setlocal foldtext=spiffy_foldtext#SpiffyFoldText()
setlocal formatexpr=
setlocal formatoptions=n21jcroql
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatprg=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=\\<require(\\([\"']\\)\\zs[^\\1]\\+\\ze\\1
setlocal includeexpr=node#lib#find(v:fname,\ bufname('%'))
setlocal indentexpr=GetJavascriptIndent()
setlocal indentkeys=0{,0},:,0#,!^F,o,O,e,0],0)
setlocal infercase
setlocal iskeyword=@,48-57,_,192-255,$
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal lispwords=
setlocal nolist
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=bin,octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=javascriptcomplete#CompleteJS
setlocal path=.,,
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
set relativenumber
setlocal relativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=4
setlocal noshortname
setlocal signcolumn=auto
setlocal nosmartindent
setlocal softtabstop=4
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=%{lightline#link()}%#LightlineLeft_active_0#%(\ %{lightline#mode()}\ %)%{(&paste)?\"|\":\"\"}%(\ %{&paste?\"PASTE\":\"\"}\ %)%#LightlineLeft_active_0_1#%#LightlineLeft_active_1#%(\ %{LightlineReadonly()}\ %)%{LightlineReadonly()!=#\"\"&&(1||(&modified||!&modifiable))?\"|\":\"\"}%(\ %t\ %)%{(&modified||!&modifiable)?\"|\":\"\"}%(\ %M\ %)%#LightlineLeft_active_1_2#%#LightlineLeft_active_2#%(\ %{LightlineGitBranch()}\ %)%#LightlineLeft_active_2_3#%#LightlineMiddle_active#%=%#LightlineRight_active_4_5#%#LightlineRight_active_4#%#LightlineRight_active_3_4#%#LightlineRight_active_3#%(\ %{&ff}\ %)%{1||1?\"|\":\"\"}%(\ %{&fenc!=#\"\"?&fenc:&enc}\ %)%{1?\"|\":\"\"}%(\ %{&ft!=#\"\"?&ft:\"no\ ft\"}\ %)%#LightlineRight_active_2_3#%#LightlineRight_active_2#%(\ %3p%%\ %)%#LightlineRight_active_1_2#%#LightlineRight_active_1#%(\ %3l:%-2v\ %)%#LightlineRight_active_info_1#%#LightlineRight_active_info#%(\ 5\ %)%#LightlineRight_active_warning_info#%#LightlineRight_active_warning#%(\ 6\ %)
setlocal suffixesadd=.js,.js,.json,.es,.jsx
setlocal swapfile
setlocal synmaxcol=400
if &syntax != 'javascript'
setlocal syntax=javascript
endif
setlocal tabstop=4
setlocal tagcase=
setlocal tags=
setlocal termwinkey=
setlocal termwinscroll=10000
setlocal termwinsize=
setlocal textwidth=0
setlocal thesaurus=
setlocal undofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal nowinfixheight
setlocal nowinfixwidth
set nowrap
setlocal nowrap
setlocal wrapmargin=0
16
normal! zo
16
normal! zo
25
normal! zo
25
normal! zo
29
normal! zo
30
normal! zo
30
normal! zo
37
normal! zo
38
normal! zo
42
normal! zo
51
normal! zo
51
normal! zo
59
normal! zo
69
normal! zo
73
normal! zo
78
normal! zo
82
normal! zo
51
normal! zo
59
normal! zo
69
normal! zo
73
normal! zo
77
normal! zo
78
normal! zo
83
normal! zo
78
normal! zo
83
normal! zo
89
normal! zo
95
normal! zo
99
normal! zo
109
normal! zo
112
normal! zo
121
normal! zo
110
normal! zo
111
normal! zo
122
normal! zo
let s:l = 112 - ((17 * winheight(0) + 17) / 35)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
112
let s:c = 112 - ((56 * winwidth(0) + 59) / 119)
if s:c > 0
  exe 'normal! ' . s:c . '|zs' . 112 . '|'
else
  normal! 0112|
endif
wincmd w
argglobal
if bufexists("~/Repositories/woody-html/html/lib/ember-bbva-components/addon/pods/components/compositions/composition-carousel-loop/template.hbs") | buffer ~/Repositories/woody-html/html/lib/ember-bbva-components/addon/pods/components/compositions/composition-carousel-loop/template.hbs | else | edit ~/Repositories/woody-html/html/lib/ember-bbva-components/addon/pods/components/compositions/composition-carousel-loop/template.hbs | endif
let s:cpo_save=&cpo
set cpo&vim
inoremap <buffer> <silent> <BS> =AutoPairsDelete()
nmap <buffer>  hp <Plug>GitGutterPreviewHunk
nmap <buffer>  hu <Plug>GitGutterUndoHunk
nmap <buffer>  hs <Plug>GitGutterStageHunk
inoremap <buffer> <silent> § =AutoPairsMoveCharacter('''')
inoremap <buffer> <silent> ¢ =AutoPairsMoveCharacter('"')
inoremap <buffer> <silent> © =AutoPairsMoveCharacter(')')
inoremap <buffer> <silent> ¨ =AutoPairsMoveCharacter('(')
inoremap <buffer> <silent> î :call AutoPairsJump()a
inoremap <buffer> <silent> <expr> ð AutoPairsToggle()
inoremap <buffer> <silent> å =AutoPairsFastWrap()
inoremap <buffer> <silent> ý =AutoPairsMoveCharacter('}')
inoremap <buffer> <silent> û =AutoPairsMoveCharacter('{')
inoremap <buffer> <silent> Ý =AutoPairsMoveCharacter(']')
inoremap <buffer> <silent> Û =AutoPairsMoveCharacter('[')
nmap <buffer> [c <Plug>GitGutterPrevHunk
nmap <buffer> ]c <Plug>GitGutterNextHunk
xmap <buffer> ac <Plug>GitGutterTextObjectOuterVisual
omap <buffer> ac <Plug>GitGutterTextObjectOuterPending
xmap <buffer> ic <Plug>GitGutterTextObjectInnerVisual
omap <buffer> ic <Plug>GitGutterTextObjectInnerPending
inoremap <buffer> <silent>  =AutoPairsBackInsert()
inoremap <buffer> <silent>  =AutoPairsDelete()
inoremap <buffer> <silent>   =AutoPairsSpace()
inoremap <buffer> <silent> " =AutoPairsInsert('"')
inoremap <buffer> <silent> ' =AutoPairsInsert('''')
inoremap <buffer> <silent> ( =AutoPairsInsert('(')
inoremap <buffer> <silent> ) =AutoPairsInsert(')')
nnoremap <buffer> <silent> î :call AutoPairsJump()
xnoremap <buffer> <silent> î :call AutoPairsJump()
onoremap <buffer> <silent> î :call AutoPairsJump()
nnoremap <buffer> <silent> ð :call AutoPairsToggle()
xnoremap <buffer> <silent> ð :call AutoPairsToggle()
onoremap <buffer> <silent> ð :call AutoPairsToggle()
inoremap <buffer> <silent> [ =AutoPairsInsert('[')
inoremap <buffer> <silent> ] =AutoPairsInsert(']')
inoremap <buffer> <silent> ` =AutoPairsInsert('`')
inoremap <buffer> <silent> { =AutoPairsInsert('{')
inoremap <buffer> <silent> } =AutoPairsInsert('}')
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal backupcopy=
setlocal balloonexpr=
setlocal nobinary
set breakindent
setlocal breakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=s:<!--,m:\ \ \ \ ,e:-->
setlocal commentstring=<!--%s-->
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
setlocal conceallevel=0
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
set cursorline
setlocal cursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal noexpandtab
if &filetype != 'html.handlebars'
setlocal filetype=html.handlebars
endif
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
set foldmethod=syntax
setlocal foldmethod=syntax
set foldminlines=0
setlocal foldminlines=0
set foldnestmax=10
setlocal foldnestmax=10
set foldtext=spiffy_foldtext#SpiffyFoldText()
setlocal foldtext=spiffy_foldtext#SpiffyFoldText()
setlocal formatexpr=
setlocal formatoptions=croqn2l1j
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatprg=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=
setlocal includeexpr=
setlocal indentexpr=GetCoffeeHtmlIndent(v:lnum)
setlocal indentkeys=o,O,<Return>,<>>,{,},!^F
setlocal infercase
setlocal iskeyword=@,48-57,_,192-255,$
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal lispwords=
setlocal nolist
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:],<:>
setlocal modeline
setlocal modifiable
setlocal nrformats=bin,octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=htmlcomplete#CompleteTags
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norelativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=4
setlocal noshortname
setlocal signcolumn=auto
setlocal nosmartindent
setlocal softtabstop=4
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=%{lightline#link()}%#LightlineLeft_inactive_0#%(\ %t\ %)%#LightlineLeft_inactive_0_1#%#LightlineMiddle_inactive#%=%#LightlineRight_inactive_1_2#%#LightlineRight_inactive_1#%(\ %3p%%\ %)%#LightlineRight_inactive_0_1#%#LightlineRight_inactive_0#%(\ %3l:%-2v\ %)
setlocal suffixesadd=
setlocal swapfile
setlocal synmaxcol=400
if &syntax != 'handlebars'
setlocal syntax=handlebars
endif
setlocal tabstop=4
setlocal tagcase=
setlocal tags=
setlocal termwinkey=
setlocal termwinscroll=10000
setlocal termwinsize=
setlocal textwidth=0
setlocal thesaurus=
setlocal undofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal nowinfixheight
setlocal nowinfixwidth
set nowrap
setlocal nowrap
setlocal wrapmargin=0
let s:l = 7 - ((6 * winheight(0) + 17) / 34)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
7
normal! 039|
wincmd w
argglobal
if bufexists("~/Repositories/woody-html/html/lib/ember-bbva-components/addon/pods/components/compositions/composition-carousel-loop/-virtual/component.js") | buffer ~/Repositories/woody-html/html/lib/ember-bbva-components/addon/pods/components/compositions/composition-carousel-loop/-virtual/component.js | else | edit ~/Repositories/woody-html/html/lib/ember-bbva-components/addon/pods/components/compositions/composition-carousel-loop/-virtual/component.js | endif
let s:cpo_save=&cpo
set cpo&vim
inoremap <buffer> <silent> <BS> =AutoPairsDelete()
nmap <buffer> gf <Plug>NodeTabGotoFile
nmap <buffer>  <Plug>NodeSplitGotoFile
nmap <buffer> f <Plug>NodeSplitGotoFile
nmap <buffer>  hp <Plug>GitGutterPreviewHunk
nmap <buffer>  hu <Plug>GitGutterUndoHunk
nmap <buffer>  hs <Plug>GitGutterStageHunk
inoremap <buffer> <silent> § =AutoPairsMoveCharacter('''')
inoremap <buffer> <silent> ¢ =AutoPairsMoveCharacter('"')
inoremap <buffer> <silent> © =AutoPairsMoveCharacter(')')
inoremap <buffer> <silent> ¨ =AutoPairsMoveCharacter('(')
inoremap <buffer> <silent> î :call AutoPairsJump()a
inoremap <buffer> <silent> <expr> ð AutoPairsToggle()
inoremap <buffer> <silent> å =AutoPairsFastWrap()
inoremap <buffer> <silent> ý =AutoPairsMoveCharacter('}')
inoremap <buffer> <silent> û =AutoPairsMoveCharacter('{')
inoremap <buffer> <silent> Ý =AutoPairsMoveCharacter(']')
inoremap <buffer> <silent> Û =AutoPairsMoveCharacter('[')
nmap <buffer> [c <Plug>GitGutterPrevHunk
nmap <buffer> ]c <Plug>GitGutterNextHunk
xmap <buffer> ac <Plug>GitGutterTextObjectOuterVisual
omap <buffer> ac <Plug>GitGutterTextObjectOuterPending
nmap <buffer> gf <Plug>NodeGotoFile
xmap <buffer> ic <Plug>GitGutterTextObjectInnerVisual
omap <buffer> ic <Plug>GitGutterTextObjectInnerPending
inoremap <buffer> <silent>  =AutoPairsBackInsert()
inoremap <buffer> <silent>  =AutoPairsDelete()
inoremap <buffer> <silent>   =AutoPairsSpace()
inoremap <buffer> <silent> " =AutoPairsInsert('"')
inoremap <buffer> <silent> ' =AutoPairsInsert('''')
inoremap <buffer> <silent> ( =AutoPairsInsert('(')
inoremap <buffer> <silent> ) =AutoPairsInsert(')')
nnoremap <buffer> <silent> î :call AutoPairsJump()
xnoremap <buffer> <silent> î :call AutoPairsJump()
onoremap <buffer> <silent> î :call AutoPairsJump()
nnoremap <buffer> <silent> ð :call AutoPairsToggle()
xnoremap <buffer> <silent> ð :call AutoPairsToggle()
onoremap <buffer> <silent> ð :call AutoPairsToggle()
inoremap <buffer> <silent> [ =AutoPairsInsert('[')
inoremap <buffer> <silent> ] =AutoPairsInsert(']')
inoremap <buffer> <silent> ` =AutoPairsInsert('`')
inoremap <buffer> <silent> { =AutoPairsInsert('{')
inoremap <buffer> <silent> } =AutoPairsInsert('}')
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal backupcopy=
setlocal balloonexpr=
setlocal nobinary
set breakindent
setlocal breakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://
setlocal commentstring=//%s
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
setlocal conceallevel=0
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
set cursorline
setlocal cursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal noexpandtab
if &filetype != 'javascript'
setlocal filetype=javascript
endif
setlocal fixendofline
setlocal foldcolumn=0
setlocal nofoldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
set foldmethod=syntax
setlocal foldmethod=syntax
set foldminlines=0
setlocal foldminlines=0
set foldnestmax=10
setlocal foldnestmax=10
set foldtext=spiffy_foldtext#SpiffyFoldText()
setlocal foldtext=spiffy_foldtext#SpiffyFoldText()
setlocal formatexpr=
setlocal formatoptions=n21jcroql
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatprg=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=\\<require(\\([\"']\\)\\zs[^\\1]\\+\\ze\\1
setlocal includeexpr=node#lib#find(v:fname,\ bufname('%'))
setlocal indentexpr=GetJavascriptIndent()
setlocal indentkeys=0{,0},:,0#,!^F,o,O,e,0],0)
setlocal infercase
setlocal iskeyword=@,48-57,_,192-255,$
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal lispwords=
setlocal nolist
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=bin,octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=javascriptcomplete#CompleteJS
setlocal path=.,,
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norelativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=4
setlocal noshortname
setlocal signcolumn=auto
setlocal nosmartindent
setlocal softtabstop=4
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=%{lightline#link()}%#LightlineLeft_inactive_0#%(\ %t\ %)%#LightlineLeft_inactive_0_1#%#LightlineMiddle_inactive#%=%#LightlineRight_inactive_1_2#%#LightlineRight_inactive_1#%(\ %3p%%\ %)%#LightlineRight_inactive_0_1#%#LightlineRight_inactive_0#%(\ %3l:%-2v\ %)
setlocal suffixesadd=.js,.js,.json,.es,.jsx
setlocal swapfile
setlocal synmaxcol=400
if &syntax != 'javascript'
setlocal syntax=javascript
endif
setlocal tabstop=4
setlocal tagcase=
setlocal tags=
setlocal termwinkey=
setlocal termwinscroll=10000
setlocal termwinsize=
setlocal textwidth=0
setlocal thesaurus=
setlocal undofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal nowinfixheight
setlocal nowinfixwidth
set nowrap
setlocal nowrap
setlocal wrapmargin=0
12
normal! zo
12
normal! zo
19
normal! zo
19
normal! zo
28
normal! zo
28
normal! zo
36
normal! zo
36
normal! zo
44
normal! zo
28
normal! zo
28
normal! zo
36
normal! zo
36
normal! zo
44
normal! zo
let s:l = 31 - ((17 * winheight(0) + 17) / 35)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
31
normal! 036|
wincmd w
argglobal
if bufexists("~/Repositories/woody-html/html/lib/ember-bbva-components/addon/pods/components/compositions/composition-carousel-loop/-virtual/template.hbs") | buffer ~/Repositories/woody-html/html/lib/ember-bbva-components/addon/pods/components/compositions/composition-carousel-loop/-virtual/template.hbs | else | edit ~/Repositories/woody-html/html/lib/ember-bbva-components/addon/pods/components/compositions/composition-carousel-loop/-virtual/template.hbs | endif
let s:cpo_save=&cpo
set cpo&vim
inoremap <buffer> <silent> <BS> =AutoPairsDelete()
nmap <buffer>  hp <Plug>GitGutterPreviewHunk
nmap <buffer>  hu <Plug>GitGutterUndoHunk
nmap <buffer>  hs <Plug>GitGutterStageHunk
inoremap <buffer> <silent> § =AutoPairsMoveCharacter('''')
inoremap <buffer> <silent> ¢ =AutoPairsMoveCharacter('"')
inoremap <buffer> <silent> © =AutoPairsMoveCharacter(')')
inoremap <buffer> <silent> ¨ =AutoPairsMoveCharacter('(')
inoremap <buffer> <silent> î :call AutoPairsJump()a
inoremap <buffer> <silent> <expr> ð AutoPairsToggle()
inoremap <buffer> <silent> å =AutoPairsFastWrap()
inoremap <buffer> <silent> ý =AutoPairsMoveCharacter('}')
inoremap <buffer> <silent> û =AutoPairsMoveCharacter('{')
inoremap <buffer> <silent> Ý =AutoPairsMoveCharacter(']')
inoremap <buffer> <silent> Û =AutoPairsMoveCharacter('[')
nmap <buffer> [c <Plug>GitGutterPrevHunk
nmap <buffer> ]c <Plug>GitGutterNextHunk
xmap <buffer> ac <Plug>GitGutterTextObjectOuterVisual
omap <buffer> ac <Plug>GitGutterTextObjectOuterPending
xmap <buffer> ic <Plug>GitGutterTextObjectInnerVisual
omap <buffer> ic <Plug>GitGutterTextObjectInnerPending
inoremap <buffer> <silent>  =AutoPairsBackInsert()
inoremap <buffer> <silent>  =AutoPairsDelete()
inoremap <buffer> <silent>   =AutoPairsSpace()
inoremap <buffer> <silent> " =AutoPairsInsert('"')
inoremap <buffer> <silent> ' =AutoPairsInsert('''')
inoremap <buffer> <silent> ( =AutoPairsInsert('(')
inoremap <buffer> <silent> ) =AutoPairsInsert(')')
nnoremap <buffer> <silent> î :call AutoPairsJump()
xnoremap <buffer> <silent> î :call AutoPairsJump()
onoremap <buffer> <silent> î :call AutoPairsJump()
nnoremap <buffer> <silent> ð :call AutoPairsToggle()
xnoremap <buffer> <silent> ð :call AutoPairsToggle()
onoremap <buffer> <silent> ð :call AutoPairsToggle()
inoremap <buffer> <silent> [ =AutoPairsInsert('[')
inoremap <buffer> <silent> ] =AutoPairsInsert(']')
inoremap <buffer> <silent> ` =AutoPairsInsert('`')
inoremap <buffer> <silent> { =AutoPairsInsert('{')
inoremap <buffer> <silent> } =AutoPairsInsert('}')
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal backupcopy=
setlocal balloonexpr=
setlocal nobinary
set breakindent
setlocal breakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=s:<!--,m:\ \ \ \ ,e:-->
setlocal commentstring=<!--%s-->
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
setlocal conceallevel=0
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
set cursorline
setlocal cursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal noexpandtab
if &filetype != 'html.handlebars'
setlocal filetype=html.handlebars
endif
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
set foldmethod=syntax
setlocal foldmethod=syntax
set foldminlines=0
setlocal foldminlines=0
set foldnestmax=10
setlocal foldnestmax=10
set foldtext=spiffy_foldtext#SpiffyFoldText()
setlocal foldtext=spiffy_foldtext#SpiffyFoldText()
setlocal formatexpr=
setlocal formatoptions=croqn2l1j
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatprg=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=
setlocal includeexpr=
setlocal indentexpr=GetCoffeeHtmlIndent(v:lnum)
setlocal indentkeys=o,O,<Return>,<>>,{,},!^F
setlocal infercase
setlocal iskeyword=@,48-57,_,192-255,$
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal lispwords=
setlocal nolist
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:],<:>
setlocal modeline
setlocal modifiable
setlocal nrformats=bin,octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=htmlcomplete#CompleteTags
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norelativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=4
setlocal noshortname
setlocal signcolumn=auto
setlocal nosmartindent
setlocal softtabstop=4
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=%{lightline#link()}%#LightlineLeft_inactive_0#%(\ %t\ %)%#LightlineLeft_inactive_0_1#%#LightlineMiddle_inactive#%=%#LightlineRight_inactive_1_2#%#LightlineRight_inactive_1#%(\ %3p%%\ %)%#LightlineRight_inactive_0_1#%#LightlineRight_inactive_0#%(\ %3l:%-2v\ %)
setlocal suffixesadd=
setlocal swapfile
setlocal synmaxcol=400
if &syntax != 'handlebars'
setlocal syntax=handlebars
endif
setlocal tabstop=4
setlocal tagcase=
setlocal tags=
setlocal termwinkey=
setlocal termwinscroll=10000
setlocal termwinsize=
setlocal textwidth=0
setlocal thesaurus=
setlocal undofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal nowinfixheight
setlocal nowinfixwidth
set nowrap
setlocal nowrap
setlocal wrapmargin=0
let s:l = 2 - ((1 * winheight(0) + 17) / 34)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
2
normal! 016|
wincmd w
exe '1resize ' . ((&lines * 35 + 36) / 73)
exe 'vert 1resize ' . ((&columns * 119 + 119) / 239)
exe '2resize ' . ((&lines * 34 + 36) / 73)
exe 'vert 2resize ' . ((&columns * 119 + 119) / 239)
exe '3resize ' . ((&lines * 35 + 36) / 73)
exe 'vert 3resize ' . ((&columns * 119 + 119) / 239)
exe '4resize ' . ((&lines * 34 + 36) / 73)
exe 'vert 4resize ' . ((&columns * 119 + 119) / 239)
tabnext
edit ~/Repositories/woody-html/html/lib/ember-bbva-components/addon/pods/components/compositions/composition-carousel-swipe/component.js
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 119 + 119) / 239)
exe 'vert 2resize ' . ((&columns * 119 + 119) / 239)
argglobal
let s:cpo_save=&cpo
set cpo&vim
inoremap <buffer> <silent> <BS> =AutoPairsDelete()
nmap <buffer> gf <Plug>NodeTabGotoFile
nmap <buffer>  <Plug>NodeSplitGotoFile
nmap <buffer> f <Plug>NodeSplitGotoFile
nmap <buffer>  hp <Plug>GitGutterPreviewHunk
nmap <buffer>  hu <Plug>GitGutterUndoHunk
nmap <buffer>  hs <Plug>GitGutterStageHunk
inoremap <buffer> <silent> § =AutoPairsMoveCharacter('''')
inoremap <buffer> <silent> ¢ =AutoPairsMoveCharacter('"')
inoremap <buffer> <silent> © =AutoPairsMoveCharacter(')')
inoremap <buffer> <silent> ¨ =AutoPairsMoveCharacter('(')
inoremap <buffer> <silent> î :call AutoPairsJump()a
inoremap <buffer> <silent> <expr> ð AutoPairsToggle()
inoremap <buffer> <silent> å =AutoPairsFastWrap()
inoremap <buffer> <silent> ý =AutoPairsMoveCharacter('}')
inoremap <buffer> <silent> û =AutoPairsMoveCharacter('{')
inoremap <buffer> <silent> Ý =AutoPairsMoveCharacter(']')
inoremap <buffer> <silent> Û =AutoPairsMoveCharacter('[')
nmap <buffer> [c <Plug>GitGutterPrevHunk
nmap <buffer> ]c <Plug>GitGutterNextHunk
xmap <buffer> ac <Plug>GitGutterTextObjectOuterVisual
omap <buffer> ac <Plug>GitGutterTextObjectOuterPending
nmap <buffer> gf <Plug>NodeGotoFile
xmap <buffer> ic <Plug>GitGutterTextObjectInnerVisual
omap <buffer> ic <Plug>GitGutterTextObjectInnerPending
inoremap <buffer> <silent>  =AutoPairsBackInsert()
inoremap <buffer> <silent>  =AutoPairsDelete()
inoremap <buffer> <silent>   =AutoPairsSpace()
inoremap <buffer> <silent> " =AutoPairsInsert('"')
inoremap <buffer> <silent> ' =AutoPairsInsert('''')
inoremap <buffer> <silent> ( =AutoPairsInsert('(')
inoremap <buffer> <silent> ) =AutoPairsInsert(')')
nnoremap <buffer> <silent> î :call AutoPairsJump()
xnoremap <buffer> <silent> î :call AutoPairsJump()
onoremap <buffer> <silent> î :call AutoPairsJump()
nnoremap <buffer> <silent> ð :call AutoPairsToggle()
xnoremap <buffer> <silent> ð :call AutoPairsToggle()
onoremap <buffer> <silent> ð :call AutoPairsToggle()
inoremap <buffer> <silent> [ =AutoPairsInsert('[')
inoremap <buffer> <silent> ] =AutoPairsInsert(']')
inoremap <buffer> <silent> ` =AutoPairsInsert('`')
inoremap <buffer> <silent> { =AutoPairsInsert('{')
inoremap <buffer> <silent> } =AutoPairsInsert('}')
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal backupcopy=
setlocal balloonexpr=
setlocal nobinary
set breakindent
setlocal breakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://
setlocal commentstring=//%s
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
setlocal conceallevel=0
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
set cursorline
setlocal cursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal noexpandtab
if &filetype != 'javascript'
setlocal filetype=javascript
endif
setlocal fixendofline
setlocal foldcolumn=0
setlocal nofoldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
set foldmethod=syntax
setlocal foldmethod=syntax
set foldminlines=0
setlocal foldminlines=0
set foldnestmax=10
setlocal foldnestmax=10
set foldtext=spiffy_foldtext#SpiffyFoldText()
setlocal foldtext=spiffy_foldtext#SpiffyFoldText()
setlocal formatexpr=
setlocal formatoptions=n21jcroql
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatprg=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=\\<require(\\([\"']\\)\\zs[^\\1]\\+\\ze\\1
setlocal includeexpr=node#lib#find(v:fname,\ bufname('%'))
setlocal indentexpr=GetJavascriptIndent()
setlocal indentkeys=0{,0},:,0#,!^F,o,O,e,0],0)
setlocal infercase
setlocal iskeyword=@,48-57,_,192-255,$
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal lispwords=
setlocal nolist
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=bin,octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=javascriptcomplete#CompleteJS
setlocal path=.,,
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norelativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=4
setlocal noshortname
setlocal signcolumn=auto
setlocal nosmartindent
setlocal softtabstop=4
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=%{lightline#link()}%#LightlineLeft_active_0#%(\ %{lightline#mode()}\ %)%{(&paste)?\"|\":\"\"}%(\ %{&paste?\"PASTE\":\"\"}\ %)%#LightlineLeft_active_0_1#%#LightlineLeft_active_1#%(\ %{LightlineReadonly()}\ %)%{LightlineReadonly()!=#\"\"&&(1||(&modified||!&modifiable))?\"|\":\"\"}%(\ %t\ %)%{(&modified||!&modifiable)?\"|\":\"\"}%(\ %M\ %)%#LightlineLeft_active_1_2#%#LightlineLeft_active_2#%(\ %{LightlineGitBranch()}\ %)%#LightlineLeft_active_2_3#%#LightlineMiddle_active#%=%#LightlineRight_active_4_5#%#LightlineRight_active_4#%#LightlineRight_active_3_4#%#LightlineRight_active_3#%(\ %{&ff}\ %)%{1||1?\"|\":\"\"}%(\ %{&fenc!=#\"\"?&fenc:&enc}\ %)%{1?\"|\":\"\"}%(\ %{&ft!=#\"\"?&ft:\"no\ ft\"}\ %)%#LightlineRight_active_2_3#%#LightlineRight_active_2#%(\ %3p%%\ %)%#LightlineRight_active_1_2#%#LightlineRight_active_1#%(\ %3l:%-2v\ %)%#LightlineRight_active_warning_1#%#LightlineRight_active_warning#%(\ 3\ %)
setlocal suffixesadd=.js,.js,.json,.es,.jsx
setlocal swapfile
setlocal synmaxcol=400
if &syntax != 'javascript'
setlocal syntax=javascript
endif
setlocal tabstop=4
setlocal tagcase=
setlocal tags=
setlocal termwinkey=
setlocal termwinscroll=10000
setlocal termwinsize=
setlocal textwidth=0
setlocal thesaurus=
setlocal undofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal nowinfixheight
setlocal nowinfixwidth
set nowrap
setlocal nowrap
setlocal wrapmargin=0
let s:l = 20 - ((19 * winheight(0) + 35) / 70)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
20
normal! 063|
wincmd w
argglobal
if bufexists("~/Repositories/woody-html/html/lib/ember-bbva-components/addon/mixins/component-child/index.js") | buffer ~/Repositories/woody-html/html/lib/ember-bbva-components/addon/mixins/component-child/index.js | else | edit ~/Repositories/woody-html/html/lib/ember-bbva-components/addon/mixins/component-child/index.js | endif
let s:cpo_save=&cpo
set cpo&vim
inoremap <buffer> <silent> <BS> =AutoPairsDelete()
nmap <buffer> gf <Plug>NodeTabGotoFile
nmap <buffer>  <Plug>NodeSplitGotoFile
nmap <buffer> f <Plug>NodeSplitGotoFile
nmap <buffer>  hp <Plug>GitGutterPreviewHunk
nmap <buffer>  hu <Plug>GitGutterUndoHunk
nmap <buffer>  hs <Plug>GitGutterStageHunk
inoremap <buffer> <silent> § =AutoPairsMoveCharacter('''')
inoremap <buffer> <silent> ¢ =AutoPairsMoveCharacter('"')
inoremap <buffer> <silent> © =AutoPairsMoveCharacter(')')
inoremap <buffer> <silent> ¨ =AutoPairsMoveCharacter('(')
inoremap <buffer> <silent> î :call AutoPairsJump()a
inoremap <buffer> <silent> <expr> ð AutoPairsToggle()
inoremap <buffer> <silent> å =AutoPairsFastWrap()
inoremap <buffer> <silent> ý =AutoPairsMoveCharacter('}')
inoremap <buffer> <silent> û =AutoPairsMoveCharacter('{')
inoremap <buffer> <silent> Ý =AutoPairsMoveCharacter(']')
inoremap <buffer> <silent> Û =AutoPairsMoveCharacter('[')
nmap <buffer> [c <Plug>GitGutterPrevHunk
nmap <buffer> ]c <Plug>GitGutterNextHunk
xmap <buffer> ac <Plug>GitGutterTextObjectOuterVisual
omap <buffer> ac <Plug>GitGutterTextObjectOuterPending
nmap <buffer> gf <Plug>NodeGotoFile
xmap <buffer> ic <Plug>GitGutterTextObjectInnerVisual
omap <buffer> ic <Plug>GitGutterTextObjectInnerPending
inoremap <buffer> <silent>  =AutoPairsBackInsert()
inoremap <buffer> <silent>  =AutoPairsDelete()
inoremap <buffer> <silent>   =AutoPairsSpace()
inoremap <buffer> <silent> " =AutoPairsInsert('"')
inoremap <buffer> <silent> ' =AutoPairsInsert('''')
inoremap <buffer> <silent> ( =AutoPairsInsert('(')
inoremap <buffer> <silent> ) =AutoPairsInsert(')')
nnoremap <buffer> <silent> î :call AutoPairsJump()
xnoremap <buffer> <silent> î :call AutoPairsJump()
onoremap <buffer> <silent> î :call AutoPairsJump()
nnoremap <buffer> <silent> ð :call AutoPairsToggle()
xnoremap <buffer> <silent> ð :call AutoPairsToggle()
onoremap <buffer> <silent> ð :call AutoPairsToggle()
inoremap <buffer> <silent> [ =AutoPairsInsert('[')
inoremap <buffer> <silent> ] =AutoPairsInsert(']')
inoremap <buffer> <silent> ` =AutoPairsInsert('`')
inoremap <buffer> <silent> { =AutoPairsInsert('{')
inoremap <buffer> <silent> } =AutoPairsInsert('}')
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal backupcopy=
setlocal balloonexpr=
setlocal nobinary
set breakindent
setlocal breakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://
setlocal commentstring=//%s
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
setlocal conceallevel=0
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
set cursorline
setlocal cursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal noexpandtab
if &filetype != 'javascript'
setlocal filetype=javascript
endif
setlocal fixendofline
setlocal foldcolumn=0
setlocal nofoldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
set foldmethod=syntax
setlocal foldmethod=syntax
set foldminlines=0
setlocal foldminlines=0
set foldnestmax=10
setlocal foldnestmax=10
set foldtext=spiffy_foldtext#SpiffyFoldText()
setlocal foldtext=spiffy_foldtext#SpiffyFoldText()
setlocal formatexpr=
setlocal formatoptions=n21jcroql
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatprg=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=\\<require(\\([\"']\\)\\zs[^\\1]\\+\\ze\\1
setlocal includeexpr=node#lib#find(v:fname,\ bufname('%'))
setlocal indentexpr=GetJavascriptIndent()
setlocal indentkeys=0{,0},:,0#,!^F,o,O,e,0],0)
setlocal infercase
setlocal iskeyword=@,48-57,_,192-255,$
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal lispwords=
setlocal nolist
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=bin,octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=javascriptcomplete#CompleteJS
setlocal path=.,,
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norelativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=4
setlocal noshortname
setlocal signcolumn=auto
setlocal nosmartindent
setlocal softtabstop=4
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=%{lightline#link()}%#LightlineLeft_inactive_0#%(\ %t\ %)%#LightlineLeft_inactive_0_1#%#LightlineMiddle_inactive#%=%#LightlineRight_inactive_1_2#%#LightlineRight_inactive_1#%(\ %3p%%\ %)%#LightlineRight_inactive_0_1#%#LightlineRight_inactive_0#%(\ %3l:%-2v\ %)
setlocal suffixesadd=.js,.js,.json,.es,.jsx
setlocal swapfile
setlocal synmaxcol=400
if &syntax != 'javascript'
setlocal syntax=javascript
endif
setlocal tabstop=4
setlocal tagcase=
setlocal tags=
setlocal termwinkey=
setlocal termwinscroll=10000
setlocal termwinsize=
setlocal textwidth=0
setlocal thesaurus=
setlocal undofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal nowinfixheight
setlocal nowinfixwidth
set nowrap
setlocal nowrap
setlocal wrapmargin=0
let s:l = 21 - ((20 * winheight(0) + 35) / 70)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
21
normal! 09|
wincmd w
exe 'vert 1resize ' . ((&columns * 119 + 119) / 239)
exe 'vert 2resize ' . ((&columns * 119 + 119) / 239)
tabnext 1
set stal=1
badd +19 ~/Repositories/woody-html/html/lib/ember-bbva-components/addon/pods/components/compositions/composition-carousel-swipe/README.md
badd +13 ~/Repositories/woody-html/html/lib/ember-bbva-components/addon/pods/components/compositions/composition-carousel-swipe/component.js
badd +14 ~/Repositories/woody-html/html/lib/ember-bbva-components/addon/pods/components/compositions/composition-carousel-swipe/template.hbs
badd +44 ~/Repositories/woody-html/html/lib/ember-bbva-components/package.json
badd +1 ~/Repositories/woody-html/html/lib/ember-bbva-components/addon/pods/components/compositions/composition-carousel-swipe/-slide/component.js
badd +8 ~/Repositories/woody-html/html/lib/ember-bbva-components/addon/pods/components/compositions/composition-carousel-loop/README.md
badd +17 ~/Repositories/woody-html/html/lib/ember-bbva-components/addon/pods/components/compositions/composition-carousel-loop/component.js
badd +8 ~/Repositories/woody-html/html/lib/ember-bbva-components/addon/pods/components/compositions/composition-carousel-loop/template.hbs
badd +1 ~/Repositories/woody-html/html/lib/ember-bbva-components/addon/pods/components/compositions/composition-carousel-swipe/-slide/template.hbs
badd +8 ~/Repositories/woody-html/html/lib/ember-bbva-components/tests/dummy/app/pods/application/template.hbs
badd +103 ~/Repositories/woody-html/html/lib/ember-bbva-components/addon/pods/components/badges/badge-notification/component.js
badd +94 ~/Repositories/woody-html/html/lib/ember-bbva-components/tests/dummy/app/pods/components/shadow-render/component.js
badd +9 ~/Repositories/woody-html/html/lib/ember-bbva-components/addon/pods/components/compositions/composition-carousel-loop/-virtual/component.js
badd +3 ~/Repositories/woody-html/html/lib/ember-bbva-components/addon/pods/components/compositions/composition-carousel-loop/-virtual/template.hbs
badd +1 ~/Repositories/woody-html/html/lib/ember-bbva-components/app/pods/components/compositions/composition-carousel-loop/component.js
badd +1 ~/Repositories/woody-html/html/lib/ember-bbva-components/app/pods/components/compositions/composition-carousel-loop/-virtual/component.js
badd +5 ~/Repositories/woody-html/html/lib/ember-bbva-components/tests/integration/mixins/component-child-test.js
badd +18 ~/Repositories/woody-html/html/lib/ember-bbva-components/addon/mixins/component-child/index.js
badd +24 ~/Repositories/woody-html/html/lib/ember-bbva-components/addon/mixins/component-parent/index.js
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=atIc
set winminheight=0 winminwidth=1
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
