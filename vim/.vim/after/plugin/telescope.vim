if !exists('g:loaded_telescope')
  finish
endif

nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap gb    <cmd>Telescope buffers<cr>

" nnoremap <silent> <leader><leader> <cmd>Telescope<CR>
" nnoremap <silent> <leader>ld       <cmd>Telescope diagnostics<CR>
" nnoremap <silent> <leader>lc       <cmd>Telescope commands<CR>
" nnoremap <silent> <leader>le       <cmd>Telescope extensions<CR>
" nnoremap <silent> <leader>la       <cmd>Telescope file_code_actions<CR>
" nnoremap <silent> <leader>ll       <cmd>Telescope location<CR>
" nnoremap <silent> <leader>o       <cmd>Telescope outline<CR>
" nnoremap <silent> <leader>ls       <cmd>Telescope symbols<CR>
" nnoremap <silent> <leader>lp       <cmd>Telescope<CR>

lua << EOF

local actions = require('telescope.actions')
local previewers = require('telescope.previewers')
local Job = require('plenary.job')

local new_maker = function(filepath, bufnr, opts)
    filepath = vim.fn.expand(filepath)
    Job:new({
        command = 'file',
        args = { '--mime-type', '-b', filepath },
        on_exit = function(j)
            local mime_type = vim.split(j:result()[1], '/')[1]
            if mime_type == "text" then
                previewers.buffer_previewer_maker(filepath, bufnr, opts)
            else
                -- maybe we want to write something to the buffer here
                vim.schedule(function()
                    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { 'BINARY' })
                end)
            end
        end
    }):sync()
end

require('telescope').setup {
    defaults = {
        mappings = {
            -- Mapping <Esc> to quit in insert mode
            i = {
                ["<esc>"] = actions.close
            },
        },
        -- Dont preview binaries
        buffer_previewer_maker = new_maker,
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden"
        }
    },
    pickers = {
        find_files = {
            hidden = true
        }
    },
    extensions = {
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                             -- the default case_mode is "smart_case"
        }
    }
}

require('telescope').load_extension('fzf')
require('telescope').load_extension('coc')

EOF
