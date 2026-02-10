if !exists('g:loaded_nvim_hlslens')
  finish
endif

noremap <silent> n <Cmd>execute('normal! ' . v:count1 . 'n')<CR>
            \<Cmd>lua require('hlslens').start()<CR>zzzv
noremap <silent> N <Cmd>execute('normal! ' . v:count1 . 'N')<CR>
            \<Cmd>lua require('hlslens').start()<CR>zzzv
noremap * *<Cmd>lua require('hlslens').start()<CR>zzzv
noremap # #<Cmd>lua require('hlslens').start()<CR>zzzv
noremap g* g*<Cmd>lua require('hlslens').start()<CR>zzzv
noremap g# g#<Cmd>lua require('hlslens').start()<CR>zzzv

lua << EOF

require'hlslens'.setup {
    calm_down = true,
    nearest_only = true,
}

-- Setup hlslens for scrollbar
local exists, module = pcall(require, "scrollbar.handlers.search")

if exists then
  module.setup()
end

EOF
