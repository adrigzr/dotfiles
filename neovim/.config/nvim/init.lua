-- Try to load impatient
pcall(require, "impatient")

-- Load settings
require "custom.settings"

-- Try to load packer compiled file
pcall(require, "packer_compiled")

-- Load config vimfiles
vim.api.nvim_command "runtime! config/*.vim"

-- Load packer
require "custom.plugins"

-- Load theme
require "custom.theme"
