local exists, module = pcall(require, "nvim-treesitter.configs")

if not exists then
  return
end

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.dotenv = {
  install_info = {
    url = "https://github.com/pnx/tree-sitter-dotenv",
    files = { "src/parser.c", "src/scanner.c" },
    branch = "main",
  },
  filetype = "dotenv",
}

module.setup {
  ensure_installed = {
    "bash",
    "c",
    "cmake",
    "css",
    "csv",
    "diff",
    "dockerfile",
    "dotenv",
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
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = { query = "@function.outer", desc = "Around function" },
        ["if"] = { query = "@function.inner", desc = "Inside function" },
        ["ac"] = { query = "@class.outer", desc = "Around class" },
        ["ic"] = { query = "@class.inner", desc = "Inside class" },
        ["aa"] = { query = "@parameter.outer", desc = "Around argument" },
        ["ia"] = { query = "@parameter.inner", desc = "Inside argument" },
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]m"] = { query = "@function.outer", desc = "Next function start" },
        ["]a"] = { query = "@parameter.inner", desc = "Next argument" },
      },
      goto_next_end = {
        ["]M"] = { query = "@function.outer", desc = "Next function end" },
      },
      goto_previous_start = {
        ["[m"] = { query = "@function.outer", desc = "Previous function start" },
        ["[a"] = { query = "@parameter.inner", desc = "Previous argument" },
      },
      goto_previous_end = {
        ["[M"] = { query = "@function.outer", desc = "Previous function end" },
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>sa"] = { query = "@parameter.inner", desc = "Swap with next argument" },
      },
      swap_previous = {
        ["<leader>sA"] = { query = "@parameter.inner", desc = "Swap with previous argument" },
      },
    },
  },
  indent = { enable = true, disable = { "yaml" } },
  matchup = {
    enable = true,
    include_match_words = true,
  },
}

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
