function! ProcessEslint(context) abort
    let entries = []
    for file_data in a:context['json']
        for err in file_data.messages
            let type = err.severity == 2 ? 'E' : 'W'
            let entry = {
                        \ 'maker_name': 'eslint',
                        \ 'filename': file_data.filePath,
                        \ 'text': err.message,
                        \ 'lnum': has_key(err, 'line') ? err.line : 0,
                        \ 'col': has_key(err, 'column') ? err.column : 0,
                        \ 'type': type,
                        \ }

            if has_key(err, 'endColumn')
                let entry['length'] = err.endColumn - err.column
            endif

            call add(entries, entry)
        endfor
    endfor
    return entries
endfunction

let g:neomake_enabled_makers = ['tsc', 'eslint']
let g:neomake_eslint_maker = neomake#makers#ft#javascript#eslint()
let g:neomake_eslint_maker.cwd = ''
let g:neomake_eslint_maker.args = ['--format=json', '--cache', '.']
let g:neomake_eslint_maker.process_json = function('ProcessEslint')

