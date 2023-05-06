local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
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
  "wbthomason/packer.nvim",

  -- Performance
  "lewis6991/impatient.nvim",

  -- Utils
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",
  "kevinhwang91/promise-async",
  "antoinemadec/FixCursorHold.nvim",

  -- Icons
  "kyazdani42/nvim-web-devicons",

  -- Theme
  {
    "navarasu/onedark.nvim",
    lazy = false,
    config = function()
      require "custom.theme"
    end,
  },

  -- Statusbar
  "hoob3rt/lualine.nvim",
  "arkav/lualine-lsp-progress",

  -- Search
  "windwp/nvim-spectre",
  "kevinhwang91/nvim-hlslens", -- Search Helper,
  "hauleth/sad.vim", -- Change and repeat

  -- Syntax
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" }, -- We recommend updating the parsers on update
  "nvim-treesitter/playground", -- Playground for treesitter
  "romgrk/nvim-treesitter-context", -- Add function context while scrolling
  "windwp/nvim-ts-autotag", -- Autocloses html tags
  "p00f/nvim-ts-rainbow", -- Colorize parens
  { "tpope/vim-markdown", ft = "markdown" },
  -- { "joukevandermaas/vim-ember-hbs", ft = { "handlebars", "javascript", "typescript" } },
  { "chrisbra/vim-zsh", ft = "zsh" },
  { "vim-scripts/bats.vim", ft = "bash" }, -- Bash Test Runner
  { "pantharshit00/vim-prisma", ft = "prisma" },
  -- { "sukima/vim-ember-imports", requires = "sukima/vim-javascript-imports", ft = { "javascript", "typescript" } } -- Ember Imports
  { "wannesm/wmgraphviz.vim", ft = "dot" }, -- Graphviz plugin
  { "junegunn/vader.vim", ft = "vim" }, -- Vim script tester
  { "posva/vim-vue", ft = { "javascript", "typescript" } },
  { "Quramy/vim-js-pretty-template", ft = { "javascript", "typescript" } },
  {
    "psliwka/vim-dirtytalk",
    build = ":DirtytalkUpdate",
    config = function()
      vim.opt.spelllang = { "en", "programming" }
      vim.opt.rtp:append(vim.fn.stdpath "data" .. "/site")
    end,
  }, -- Developer spell dict

  -- Navigation
  "kyazdani42/nvim-tree.lua",
  "christoomey/vim-tmux-navigator",
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- FZF for telescope
  "nvim-telescope/telescope.nvim", -- Fuzzy Finder
  "nvim-telescope/telescope-symbols.nvim", -- For symbols
  "nvim-telescope/telescope-dap.nvim",
  "debugloop/telescope-undo.nvim",
  "rgroli/other.nvim", -- Switch to alternate file

  -- Comments
  "tpope/vim-commentary",

  -- Start screen
  "glepnir/dashboard-nvim",

  -- Git
  "tpope/vim-fugitive", -- Git commands
  "lewis6991/gitsigns.nvim", -- Git gutter signs
  "rhysd/conflict-marker.vim", -- Mappings for conflicts
  "sindrets/diffview.nvim", -- Diff view

  -- Formatter
  "tpope/vim-sleuth",
  "ntpeters/vim-better-whitespace",

  -- LSP
  "williamboman/mason.nvim", -- Package client
  "williamboman/mason-lspconfig.nvim", -- Mason lspconfig extension
  "jay-babu/mason-nvim-dap.nvim", -- Mason dap extension
  "neovim/nvim-lspconfig", -- LSP config
  "jose-elias-alvarez/null-ls.nvim",
  "folke/trouble.nvim", -- Pretty diagnostics
  "b0o/schemastore.nvim", -- Schemas for jsonls
  -- use "stevearc/aerial.nvim" -- Show symbols
  "simrat39/rust-tools.nvim", -- Rust tools
  "kosayoda/nvim-lightbulb", -- Code actions lightbulb
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim", -- LSP lines
  "lvimuser/lsp-inlayhints.nvim", -- Inlay hints
  "jose-elias-alvarez/typescript.nvim", -- Typescript commands

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
  "L3MON4D3/LuaSnip",
  "rafamadriz/friendly-snippets",

  -- Misc
  "tpope/vim-repeat", -- Repeat everything
  "tpope/vim-abolish", -- Camelcase, snakecase, mixedcase coercion
  "tpope/vim-unimpaired", -- Pair aliases and toggling options
  "mjbrownie/swapit", -- <c-a> increments
  "kopischke/vim-fetch", -- Handle line number on filename
  "tpope/vim-dispatch",
  "skywind3000/asyncrun.vim", -- Async make
  "norcalli/nvim-colorizer.lua", -- Colorize hex codes
  "moll/vim-bbye", -- BufferClose commands
  "github/copilot.vim", -- Github copilot
  -- "aduros/ai.vim", -- ChatGPT
  "lukas-reineke/indent-blankline.nvim", -- Indentation guides
  -- use "tpope/vim-surround" -- Surround wrappers
  { "kylechui/nvim-surround", config = true }, -- Surround wrappers
  "windwp/nvim-autopairs", -- Auto-pairs
  { "dhruvasagar/vim-table-mode", ft = { "markdown", "cucumber" } }, -- Handle tables in markdown
  -- use { "iamcco/markdown-preview.nvim", run = "cd app && yarn install" } -- Markdown previewer
  { "tpope/vim-scriptease", lazy = false }, -- Pretty debug messages
  "folke/which-key.nvim", -- Pretty keybind hints
  -- use "petertriho/nvim-scrollbar" -- Scrollbar
  "stevearc/dressing.nvim", -- Pretty vim.ui boxes
  "andymass/vim-matchup", -- Replaces matchit & matchparen builtins
  -- use "vim-test/vim-test" -- Test files
  -- use "~/Repositories/neotest"
  "nvim-neotest/neotest",
  -- use "~/Repositories/neotest-jest"
  "haydenmeade/neotest-jest",
  -- { dir = "~/Repositories/neotest-jest" },
  { dir = "~/Repositories/neotest-mocha" },
  "nvim-neotest/neotest-plenary",
  "rouge8/neotest-rust",
  "olimorris/neotest-rspec",
  "nvim-neotest/neotest-python",
  -- "andythigpen/nvim-coverage",
  -- use "nvim-neotest/neotest-vim-test"
  -- use { "rcarriga/vim-ultest", run = ":UpdateRemotePlugins" } -- Test output in file
  "mfussenegger/nvim-dap", -- Debugger
  "theHamsta/nvim-dap-virtual-text",
  "rcarriga/nvim-dap-ui",
  -- use "anuvyklack/pretty-fold.nvim"
  -- use "stevearc/stickybuf.nvim" -- Prevent special windows to be switched to other buffer
  "kevinhwang91/nvim-ufo", -- Pretty folds
  -- "ThePrimeagen/refactoring.nvim", -- Refactoring tools
  "rcarriga/nvim-notify", -- Notifications and messages
  "anuvyklack/hydra.nvim", -- Hydra
  { "neomake/neomake", lazy = false }, -- Make presets
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = { hide_up_to_date = true },
  }, -- Show package info as virtual text in the package.json
}, {
  defaults = {
    lazy = false,
  },
  concurrency = 8,
  ui = {
    border = "rounded",
  },
})
