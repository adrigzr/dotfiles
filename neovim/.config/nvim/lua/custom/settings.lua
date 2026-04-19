local set = vim.opt

--Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Backup files
set.swapfile = true
set.writebackup = false
set.undofile = true

-- View
vim.o.winborder = "rounded"
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
set.signcolumn = "yes"
set.inccommand = "split"
set.colorcolumn = "81,101,121"
set.splitkeep = "cursor"

-- Diff
-- `set.diffopt = { ... }` replaces the option entirely, so we re-list the 0.12
-- defaults (internal, filler, closeoff, indent-heuristic, inline:char,
-- linematch:40) alongside our customisations (iwhite, algorithm:patience).
set.diffopt = {
  "internal", -- Use the internal diff library (0.12 default)
  "filler", -- Add vertical spaces to keep right and left aligned (0.12 default)
  "closeoff", -- Close diff-mode when only one window is left (0.12 default)
  "indent-heuristic", -- Use the indent heuristic (0.12 default)
  "inline:char", -- Character-level inline diff (0.12 default)
  "linematch:40", -- Second-stage diff to align changed lines up to 40 lines (0.12 default)
  "iwhite", -- Ignore whitespace changes (focus on code changes)
  "algorithm:patience", -- Use patience diff algorithm
}

-- Folds
set.foldenable = true
set.foldlevel = 99
set.foldcolumn = "1"

-- Format
set.softtabstop = 2
set.shiftwidth = 2
set.formatoptions = "croqn21lj"

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
set.timeoutlen = 500
set.ttimeoutlen = 10
set.cmdheight = 1
set.updatetime = 300
set.shada = {
  "!",
  "'500",
  "<500",
  "s512",
  "h",
}
