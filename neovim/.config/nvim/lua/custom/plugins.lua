local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Utils
  "nvim-lua/plenary.nvim",
  "kevinhwang91/promise-async",

  -- Icons (mini.icons with nvim-web-devicons compatibility shim)
  {
    "echasnovski/mini.icons",
    version = false,
    config = function()
      local mini_icons = require "mini.icons"
      mini_icons.setup()
      mini_icons.mock_nvim_web_devicons()
    end,
  },

  -- Theme
  {
    "navarasu/onedark.nvim",
    lazy = false,
    config = function()
      require "custom.theme"
    end,
  },

  -- Statusbar
  "nvim-lualine/lualine.nvim",

  -- Search
  "MagicDuck/grug-far.nvim",
  "kevinhwang91/nvim-hlslens", -- Search Helper

  -- Syntax
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" }, -- We recommend updating the parsers on update
  "nvim-treesitter/nvim-treesitter-context", -- Add function context while scrolling
  "nvim-treesitter/nvim-treesitter-textobjects", -- Function/class/argument text objects
  "windwp/nvim-ts-autotag", -- Autocloses html tags
  "HiPhish/rainbow-delimiters.nvim", -- Colorize matching delimiters
  { "wannesm/wmgraphviz.vim", ft = "dot" }, -- Graphviz plugin
  { "junegunn/vader.vim", ft = "vim" }, -- Vim script tester
  "mfussenegger/nvim-ansible",

  -- Navigation
  "christoomey/vim-tmux-navigator",
  "rgroli/other.nvim", -- Switch to alternate file

  -- Snacks (dashboard, notifier, LSP progress)
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
  },

  -- Git
  "tpope/vim-fugitive", -- Git commands
  "lewis6991/gitsigns.nvim", -- Git gutter signs
  { "akinsho/git-conflict.nvim", version = "2.*", config = true }, -- Git conflict resolution
  "sindrets/diffview.nvim", -- Diff view

  -- Formatter
  "tpope/vim-sleuth",
  { "echasnovski/mini.trailspace", version = false },
  "stevearc/conform.nvim", -- Format runner with fallback chains

  -- LSP
  "williamboman/mason.nvim", -- Package client
  "neovim/nvim-lspconfig", -- LSP config
  { "folke/lazydev.nvim", ft = "lua", opts = {} }, -- Lua LSP workspace
  "folke/trouble.nvim", -- Pretty diagnostics
  "folke/todo-comments.nvim", -- Highlight TODO/FIXME/HACK in comments
  "b0o/schemastore.nvim", -- Schemas for jsonls
  { "pmizio/typescript-tools.nvim", dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" } }, -- Typescript tools

  -- Completion
  {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = {
      { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
      "rafamadriz/friendly-snippets",
    },
  },

  -- Misc
  "tpope/vim-abolish", -- Camelcase, snakecase, mixedcase coercion
  "monaqa/dial.nvim", -- Enhanced <C-a>/<C-x> increments
  "kopischke/vim-fetch", -- Handle line number on filename
  { "kylechui/nvim-surround", config = true }, -- Surround wrappers
  { "echasnovski/mini.pairs", version = false }, -- Auto-pairs
  { "dhruvasagar/vim-table-mode", ft = { "markdown", "cucumber" } }, -- Handle tables in markdown
  "folke/which-key.nvim", -- Pretty keybind hints
  "andymass/vim-matchup", -- Replaces matchit & matchparen builtins
  "nvim-neotest/neotest",
  "haydenmeade/neotest-jest",
  "adrigzr/neotest-mocha",
  "rouge8/neotest-rust",
  "olimorris/neotest-rspec",
  "nvim-neotest/neotest-python",
  "kevinhwang91/nvim-ufo", -- Pretty folds
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = { hide_up_to_date = true },
  }, -- Show package info as virtual text in the package.json
  "axelvc/template-string.nvim",
  "zbirenbaum/copilot.lua",
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "nickjvandyke/opencode.nvim",
    dependencies = {
      "folke/snacks.nvim",
    },
  },
}, {
  defaults = {
    lazy = false,
  },
  concurrency = 8,
  ui = {
    border = "rounded",
  },
})
