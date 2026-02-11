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
  -- Meta
  -- "wbthomason/packer.nvim",

  -- Utils
  "nvim-lua/plenary.nvim",
  "kevinhwang91/promise-async",

  -- Icons
  "nvim-tree/nvim-web-devicons",

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
  "kevinhwang91/nvim-hlslens", -- Search Helper,
  "hauleth/sad.vim", -- Change and repeat

  -- Syntax
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" }, -- We recommend updating the parsers on update
  "nvim-treesitter/nvim-treesitter-context", -- Add function context while scrolling
  "windwp/nvim-ts-autotag", -- Autocloses html tags
  "HiPhish/rainbow-delimiters.nvim", -- Colorize matching delimiters
  -- { "tpope/vim-markdown", ft = "markdown" }, -- Removed: treesitter markdown parser
  -- { "joukevandermaas/vim-ember-hbs", ft = { "handlebars", "javascript", "typescript" } },
  -- { "chrisbra/vim-zsh", ft = "zsh" }, -- Removed: treesitter bash parser
  -- { "vim-scripts/bats.vim", ft = "bash" }, -- Removed: treesitter bash parser
  -- { "pantharshit00/vim-prisma", ft = "prisma" }, -- Removed: treesitter prisma parser
  -- { "sukima/vim-ember-imports", requires = "sukima/vim-javascript-imports", ft = { "javascript", "typescript" } } -- Ember Imports
  { "wannesm/wmgraphviz.vim", ft = "dot" }, -- Graphviz plugin
  { "junegunn/vader.vim", ft = "vim" }, -- Vim script tester
  -- { "posva/vim-vue", ft = { "javascript", "typescript" } }, -- Removed: treesitter vue parser
  -- { "Quramy/vim-js-pretty-template", ft = { "javascript", "typescript" } }, -- Removed: treesitter handles template literals
  -- {
  --   "psliwka/vim-dirtytalk",
  --   build = ":DirtytalkUpdate",
  --   config = function()
  --     vim.opt.spelllang = { "en", "programming" }
  --     vim.opt.rtp:append(vim.fn.stdpath "data" .. "/site")
  --   end,
  -- }, -- Developer spell dict
  "mfussenegger/nvim-ansible",

  -- Navigation
  "nvim-tree/nvim-tree.lua",
  "christoomey/vim-tmux-navigator",
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- FZF for telescope
  "nvim-telescope/telescope.nvim", -- Fuzzy Finder
  "nvim-telescope/telescope-symbols.nvim", -- For symbols
  -- "nvim-telescope/telescope-dap.nvim",
  "debugloop/telescope-undo.nvim",
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
  "ntpeters/vim-better-whitespace",

  -- LSP
  "williamboman/mason.nvim", -- Package client
  -- "jay-babu/mason-nvim-dap.nvim", -- Mason dap extension
  "neovim/nvim-lspconfig", -- LSP config
  { "folke/lazydev.nvim", ft = "lua", opts = {} }, -- Lua LSP workspace
  -- "jose-elias-alvarez/null-ls.nvim",
  "folke/trouble.nvim", -- Pretty diagnostics
  "b0o/schemastore.nvim", -- Schemas for jsonls
  -- use "stevearc/aerial.nvim" -- Show symbols

  -- "lvimuser/lsp-inlayhints.nvim", -- Inlay hints
  -- "jose-elias-alvarez/typescript.nvim", -- Typescript commands
  { "pmizio/typescript-tools.nvim", dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" } }, -- Typescript tools
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-tree.lua" },
    config = function()
      require("lsp-file-operations").setup()
    end,
  },

  -- Completion
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-nvim-lua",
  "hrsh7th/cmp-calc",
  "ray-x/cmp-treesitter",
  "f3fora/cmp-spell",
  "onsails/lspkind-nvim", -- Pretty completion items
  "saadparwaiz1/cmp_luasnip",
  "petertriho/cmp-git",
  { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
  "rafamadriz/friendly-snippets",

  -- Misc
  -- "tpope/vim-repeat", -- Removed: modern Lua plugins handle dot-repeat natively
  "tpope/vim-abolish", -- Camelcase, snakecase, mixedcase coercion
  "mjbrownie/swapit", -- <c-a> increments
  "kopischke/vim-fetch", -- Handle line number on filename
  -- "tpope/vim-dispatch", -- Removed: Neovim has built-in async jobs and terminal
  -- "skywind3000/asyncrun.vim", -- Removed: Neovim has built-in async jobs and terminal
  -- "catgoose/nvim-colorizer.lua", -- Removed: not needed
  "moll/vim-bbye", -- BufferClose commands
  -- "github/copilot.vim", -- Github copilot
  -- "aduros/ai.vim", -- ChatGPT
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
  -- use "tpope/vim-surround" -- Surround wrappers
  { "kylechui/nvim-surround", config = true }, -- Surround wrappers
  "windwp/nvim-autopairs", -- Auto-pairs
  { "dhruvasagar/vim-table-mode", ft = { "markdown", "cucumber" } }, -- Handle tables in markdown
  -- use { "iamcco/markdown-preview.nvim", run = "cd app && yarn install" } -- Markdown previewer
  -- { "tpope/vim-scriptease", lazy = false }, -- Removed: :Inspect replaces zS, Lua REPL covers the rest
  "folke/which-key.nvim", -- Pretty keybind hints
  -- use "petertriho/nvim-scrollbar" -- Scrollbar
  -- "stevearc/dressing.nvim", -- Removed: archived by author, snacks.nvim handles vim.ui
  "andymass/vim-matchup", -- Replaces matchit & matchparen builtins
  -- use "vim-test/vim-test" -- Test files
  -- use "~/Repositories/neotest"
  "nvim-neotest/neotest",
  -- use "~/Repositories/neotest-jest"
  "haydenmeade/neotest-jest",
  "adrigzr/neotest-mocha",
  -- { dir = "~/Repositories/neotest-jest" },
  -- { dir = "~/Repositories/neotest-mocha" },

  "rouge8/neotest-rust",
  "olimorris/neotest-rspec",
  "nvim-neotest/neotest-python",
  -- "andythigpen/nvim-coverage",
  -- use "nvim-neotest/neotest-vim-test"
  -- use { "rcarriga/vim-ultest", run = ":UpdateRemotePlugins" } -- Test output in file
  -- "mfussenegger/nvim-dap", -- Debugger
  -- "nvim-neotest/nvim-nio", -- Dependency for nvim-dap-ui
  -- "theHamsta/nvim-dap-virtual-text",
  -- "rcarriga/nvim-dap-ui",
  -- use "anuvyklack/pretty-fold.nvim"
  -- use "stevearc/stickybuf.nvim" -- Prevent special windows to be switched to other buffer
  "kevinhwang91/nvim-ufo", -- Pretty folds
  -- "ThePrimeagen/refactoring.nvim", -- Refactoring tools

  -- "anuvyklack/hydra.nvim", -- Hydra
  -- { "neomake/neomake", lazy = false }, -- Make presets
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = { hide_up_to_date = true },
  }, -- Show package info as virtual text in the package.json
  "axelvc/template-string.nvim",
  "zbirenbaum/copilot.lua",
  "nickjvandyke/opencode.nvim",
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = { debug = false },
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
