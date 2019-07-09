if !exists('g:loaded_denite')
  finish
endif

" Mappings.
nnoremap <silent> <C-p> :<C-u>Denite file/rec -split=floating -winrow=1<CR>
nnoremap <silent> gb :<C-u>Denite buffer -split=floating -winrow=1<CR>
nnoremap <silent> <leader>f :<C-u>Denite grep:. -no-empty -mode=normal<CR>

" Search current directory for files.
call denite#custom#var('file/rec', 'command', ['rg', '--hidden', '--smart-case', '--files', '--glob', '!.git'])

" Use ripgrep in place of grep.
call denite#custom#var('grep', 'command', ['rg'])

" Custom options for ripgrep.
call denite#custom#var('grep', 'default_opts', ['--hidden', '--vimgrep', '--heading', '--smart-case'])

" Recommended defaults for ripgrep.
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Remove date from buffer list.
call denite#custom#var('buffer', 'date_format', '')

" Use <C-a> to move all search to quickfix.
call denite#custom#map('normal', '<C-a>',
      \ '<denite:multiple_mappings:denite:toggle_select_all'.
      \ ',denite:do_action:quickfix>', 'noremap')

" Custom options.
call denite#custom#option('default', {
      \ 'auto_resize': 1,
      \ 'prompt': 'λ:',
      \ 'direction': 'dynamictop',
      \ 'winminheight': '10',
      \ 'highlight_mode_insert': 'Visual',
      \ 'highlight_mode_normal': 'Visual',
      \ 'prompt_highlight': 'Function',
      \ 'highlight_matched_char': 'Function',
      \ 'highlight_matched_range': 'Normal'
      \ })
