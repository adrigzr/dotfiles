local set = vim.opt

--Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Backup files
set.swapfile = true
set.writebackup = false
set.undofile = true

-- View
set.laststatus = 3 -- single status line
set.winbar = "%f %m%r"
set.cursorline = true
set.wrap = false
set.breakindent = true
set.showbreak = "⤷"
set.number = true
set.mouse = "a"
set.mousescroll = "ver:2,hor:2"
set.scrolloff = 6
set.sidescrolloff = 3
set.splitbelow = true
set.splitright = true
set.fillchars = "eob: ,fold: ,foldopen:,foldsep: ,foldclose:"
set.iskeyword:append "-"
set.list = true
set.listchars = "tab:→ ,extends:›,precedes:‹,nbsp:·,trail:·"
set.termguicolors = true
set.signcolumn = "yes"
set.inccommand = "split"
set.colorcolumn = "81,101,121"
-- Enable this when available
-- set.splitkeep = "cursor"

-- Diff
set.diffopt = {
  "filler", -- Add vertical spaces to keep right and left aligned
  "iwhite", -- Ignore whitespace changes (focus on code changes)
  "internal", -- Use the internal diff library
  "indent-heuristic", -- Use the indent heuristic
  "algorithm:patience", -- Use patience diff algorithm
}

-- Folds
set.foldenable = true
set.foldlevel = 99
set.foldcolumn = "1"
-- set.foldmethod = "syntax"
-- set.foldminlines = 2

-- Format
set.softtabstop = 2
set.shiftwidth = 2
set.formatoptions = ""
set.formatoptions:append "c"
set.formatoptions:append "r"
set.formatoptions:append "o"
set.formatoptions:append "q"
set.formatoptions:append "n"
set.formatoptions:append "2"
set.formatoptions:append "l"
set.formatoptions:append "1"
set.formatoptions:append "j"

-- Search
set.gdefault = true
set.ignorecase = true
set.report = 0
set.smartcase = true
set.infercase = true

-- Complete menu
set.wildmode = { "list:longest", "full" }
set.wildignorecase = true
set.completeopt = { "menu", "menuone", "noselect" }
set.pumheight = 10

-- Misc
set.spelllang = { "en", "programming" }
set.lazyredraw = true
set.timeoutlen = 500
set.ttimeoutlen = 10
set.cmdheight = 1
set.updatetime = 300
set.pyxversion = 3
set.shada = {
  "!",
  "'9999",
  "<500",
  "s512",
  "h",
}