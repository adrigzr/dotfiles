if !exists('g:loaded_nvim_treesitter')
  finish
endif

lua << EOF

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = { enable = true },
  incremental_selection = { enable = true, },
  textobjects = { enable = true },
  indent = { enable = true },
  rainbow = { enable = true },
  playground = { enable = true },
  query_linter = { enable = true },
  autotag = { enable = true },
  matchup = {
    enable = true,
    include_match_words = true
  },
}

EOF

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
