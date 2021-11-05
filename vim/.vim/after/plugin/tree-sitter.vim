if !exists('g:loaded_nvim_treesitter')
  finish
endif

lua << EOF

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true
  },
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    colors = {
        vim.g.terminal_color_1,
        vim.g.terminal_color_2,
        vim.g.terminal_color_3,
        vim.g.terminal_color_4,
        vim.g.terminal_color_5,
        vim.g.terminal_color_6,
        vim.g.terminal_color_7,
      }
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  }
}

EOF
