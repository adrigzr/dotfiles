" Dont open qf on warnins.
let g:vimtex_quickfix_open_on_warning=0

" Configure Skim as viewer.
let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r @line @pdf @tex'

" Folds.
let g:vimtex_fold_enabled = 1

" Update Skim after compilation.
let g:vimtex_compiler_callback_hooks = ['UpdateSkim']

function! UpdateSkim(status) abort
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
endfunction
