local exists, module = pcall(require, "nvim-treesitter.configs")

if not exists then
  return
end

module.setup {
  ensure_installed = "all",
  ignore_install = { "phpdoc", "swift" },
  highlight = { enable = true },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
  indent = { enable = true, disable = { "yaml" } },
  rainbow = { enable = true },
  playground = { enable = true },
  query_linter = { enable = true },
  autotag = { enable = true },
  matchup = {
    enable = true,
    include_match_words = true,
  },
}

vim.cmd [[
  set foldmethod=expr
  set foldexpr=nvim_treesitter#foldexpr()
]]
