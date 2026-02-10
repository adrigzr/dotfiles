local exists, module = pcall(require, "nvim-treesitter.configs")

if not exists then
  return
end

module.setup {
  ensure_installed = {
    "bash",
    "c",
    "cmake",
    "comment",
    "css",
    "csv",
    "diff",
    "dockerfile",
    "git_config",
    "git_rebase",
    "gitcommit",
    "gitignore",
    "graphql",
    "html",
    "http",
    "javascript",
    "jsdoc",
    "json",
    "jsonc",
    "lua",
    "luadoc",
    "luap",
    "make",
    "markdown",
    "markdown_inline",
    "prisma",
    "python",
    "query",
    "regex",
    "ruby",
    "rust",
    "scss",
    "sql",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "vue",
    "xml",
    "yaml",
  },
  highlight = { enable = true },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
  indent = { enable = true, disable = { "yaml" } },
  matchup = {
    enable = true,
    include_match_words = true,
  },
}

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
