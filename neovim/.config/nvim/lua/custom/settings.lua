local set = vim.opt

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Backup files
set.swapfile = false
set.writebackup = false
set.undofile = true

-- View
set.cursorline = true
set.wrap = false
set.breakindent = true
set.showbreak = '⤷'
set.number = true
set.mouse = 'n'
set.scrolloff = 6
set.sidescrolloff = 3
set.splitbelow = true
set.splitright = true
set.fillchars = 'fold:-'
set.iskeyword:append('-')
set.list = true
set.listchars = 'tab:→ ,extends:›,precedes:‹,nbsp:·,trail:·'
set.termguicolors = true

-- Diff
set.diffopt = {
  'filler', -- Add vertical spaces to keep right and left aligned
  'iwhite', -- Ignore whitespace changes (focus on code changes)
  'internal', -- Use the internal diff library
  'indent-heuristic', -- Use the indent heuristic
  'algorithm:patience' -- Use patience diff algorithm
}

-- Folds
set.foldenable = false
set.foldlevel = 2
set.foldmethod = 'syntax'

-- Format
set.softtabstop = 2
set.shiftwidth = 4
set.formatoptions = ''
set.formatoptions:append('c') -- Format comments
set.formatoptions:append('r') -- Continue comments by default
set.formatoptions:append('o') -- Make comment when using o or O from comment line
set.formatoptions:append('q') -- Format comments with gq
set.formatoptions:append('n') -- Recognize numbered lists
set.formatoptions:append('2') -- Use indent from 2nd line of a paragraph
set.formatoptions:append('l') -- Don't break lines that are already long
set.formatoptions:append('1') -- Break before 1-letter words
set.formatoptions:append('j') -- Join comments without leader.

-- Search
set.gdefault = true
set.ignorecase = true
set.report = 0
set.smartcase = true
set.infercase = true

-- Complete menu
set.wildmode = {'list:longest', 'full'}
set.wildignorecase = true
set.completeopt = {'menu', 'menuone', 'noselect'}

-- Misc
set.lazyredraw = true
set.timeoutlen = 500
set.ttimeoutlen = 10
set.cmdheight = 2
set.updatetime = 300
set.pyxversion = 3
set.shada = {
  "'9999",
  's512',
}
