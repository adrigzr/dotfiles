-- Install packer
local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
end

vim.cmd [[
  augroup packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]]

-- Plugins
local packer = require "packer"
local use = packer.use

packer.startup {
  function()
    -- Meta
    use "wbthomason/packer.nvim"

    -- Performance
    use "lewis6991/impatient.nvim"

    -- Utils
    use "nvim-lua/popup.nvim"
    use "nvim-lua/plenary.nvim"
    use "kevinhwang91/promise-async"
    use "antoinemadec/FixCursorHold.nvim"

    -- Icons
    use {
      "kyazdani42/nvim-web-devicons",
      config = function()
        require("nvim-web-devicons").setup {}
      end,
    }

    -- Theme
    use "navarasu/onedark.nvim"

    -- Statusbar
    use "hoob3rt/lualine.nvim"
    use "arkav/lualine-lsp-progress"

    -- Search
    use { "windwp/nvim-spectre", module = "spectre" } -- Classic Search & Replace
    use "kevinhwang91/nvim-hlslens" -- Search Helper
    use "hauleth/sad.vim" -- Change and repeat

    -- Syntax
    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" } -- We recommend updating the parsers on update
    use "nvim-treesitter/playground" -- Playground for treesitter
    use "romgrk/nvim-treesitter-context" -- Add function context while scrolling
    use "SmiteshP/nvim-gps" -- Add context to the status line
    use "windwp/nvim-ts-autotag" -- Autocloses html tags
    use "p00f/nvim-ts-rainbow" -- Colorize parens
    use { "tpope/vim-markdown", ft = "markdown" }
    use { "joukevandermaas/vim-ember-hbs", ft = { "handlebars", "javascript", "typescript" } }
    use { "chrisbra/vim-zsh", ft = "zsh" }
    use { "vim-scripts/bats.vim", ft = "bash" } -- Bash Test Runner
    use { "pantharshit00/vim-prisma", ft = "prisma" }
    use { "sukima/vim-ember-imports", requires = "sukima/vim-javascript-imports", ft = { "javascript", "typescript" } } -- Ember Imports
    use { "wannesm/wmgraphviz.vim", ft = "dot" } -- Graphviz plugin
    use { "junegunn/vader.vim", ft = "vim" } -- Vim script tester
    use { "posva/vim-vue", ft = { "javascript", "typescript" } }
    use { "Quramy/vim-js-pretty-template", ft = { "javascript", "typescript" } }

    -- Navigation
    use { "kyazdani42/nvim-tree.lua", module = "nvim-tree" }
    use "christoomey/vim-tmux-navigator"
    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" } -- FZF for telescope
    use "nvim-telescope/telescope.nvim" -- Fuzzy Finder
    use "nvim-telescope/telescope-symbols.nvim" -- For symbols
    use "nvim-telescope/telescope-dap.nvim"

    -- Comments
    use "tpope/vim-commentary"

    -- Start screen
    use "glepnir/dashboard-nvim"

    -- Git
    use "tpope/vim-fugitive" -- Git commands
    use "lewis6991/gitsigns.nvim" -- Git gutter signs
    use "rhysd/conflict-marker.vim" -- Mappings for conflicts
    use {
      "sindrets/diffview.nvim",
      config = function()
        require("diffview").setup {}
      end,
    } -- Diff view

    -- Formatter
    use "tpope/vim-sleuth"
    use "ntpeters/vim-better-whitespace"

    -- LSP
    use "neovim/nvim-lspconfig"
    use "williamboman/nvim-lsp-installer"
    use "jose-elias-alvarez/null-ls.nvim"
    use "folke/trouble.nvim" -- Pretty diagnostics
    use "b0o/schemastore.nvim" -- Schemas for jsonls
    -- use "stevearc/aerial.nvim" -- Show symbols
    use {
      "simrat39/rust-tools.nvim",
      config = function()
        require("rust-tools").setup {}
      end,
    } -- Rust tools
    use "jose-elias-alvarez/nvim-lsp-ts-utils" -- TypeScript utils
    use "kosayoda/nvim-lightbulb" -- Code actions lightbulb

    -- Completion
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/cmp-nvim-lua"
    use "hrsh7th/cmp-calc"
    use "ray-x/cmp-treesitter"
    use "f3fora/cmp-spell"
    use "onsails/lspkind-nvim" -- Pretty completion items
    use "saadparwaiz1/cmp_luasnip"
    use "petertriho/cmp-git"
    use "L3MON4D3/LuaSnip"
    use "rafamadriz/friendly-snippets"

    -- Misc
    use "tpope/vim-repeat" -- Repeat everything
    use "tpope/vim-abolish" -- Camelcase, snakecase, mixedcase coercion
    use "tpope/vim-unimpaired" -- Pair aliases and toggling options
    use "mjbrownie/swapit" -- <c-a> increments
    use "kopischke/vim-fetch" -- Handle line number on filename
    use "tpope/vim-dispatch"
    use "skywind3000/asyncrun.vim" -- Async make
    use {
      "norcalli/nvim-colorizer.lua",
      config = function()
        require("colorizer").setup {}
      end,
    } -- Colorize hex codes
    use "moll/vim-bbye" -- BufferClose commands
    use "github/copilot.vim" -- Github copilot
    use "lukas-reineke/indent-blankline.nvim" -- Indentation guides
    use "tpope/vim-surround" -- Surround wrappers
    use "windwp/nvim-autopairs" -- Auto-pairs
    use { "dhruvasagar/vim-table-mode", ft = "markdown" } -- Handle tables in markdown
    use { "iamcco/markdown-preview.nvim", run = "cd app && yarn install" } -- Markdown previewer
    use "tpope/vim-scriptease" -- Pretty debug messages
    use "folke/which-key.nvim" -- Pretty keybind hints
    use "petertriho/nvim-scrollbar" -- Scrollbar
    use "stevearc/dressing.nvim" -- Pretty vim.ui boxes
    use "andymass/vim-matchup" -- Replaces matchit & matchparen builtins
    -- use "vim-test/vim-test" -- Test files
    use "nvim-neotest/neotest"
    use "~/Repositories/neotest-jest"
    use "olimorris/neotest-rspec"
    use "nvim-neotest/neotest-python"
    -- use "nvim-neotest/neotest-vim-test"
    -- use { "rcarriga/vim-ultest", run = ":UpdateRemotePlugins" } -- Test output in file
    use "mfussenegger/nvim-dap" -- Debugger
    use "theHamsta/nvim-dap-virtual-text"
    use "rcarriga/nvim-dap-ui"
    -- use "anuvyklack/pretty-fold.nvim"
    -- use "stevearc/stickybuf.nvim" -- Prevent special windows to be switched to other buffer
    use "kevinhwang91/nvim-ufo" -- Pretty folds
    use "ThePrimeagen/refactoring.nvim" -- Refactoring tools
    use "rcarriga/nvim-notify" -- Notifications and messages
    use "anuvyklack/hydra.nvim" -- Hydra

    if packer_bootstrap then
      packer.sync()
    end
  end,
  config = {
    max_jobs = 8,
    compile_path = vim.fn.stdpath "config" .. "/lua/packer_compiled.lua",
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  },
}
