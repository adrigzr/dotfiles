local exists, spectre = pcall(require, "spectre")

if not exists then
  return
end

local misc = require "custom.util.misc"

-- Open spectre
vim.keymap.set("n", "<leader>ss", spectre.open)

-- Search current word
vim.keymap.set("n", "<leader>sw", misc.bind(spectre.open_visual, { { select_word = true } }))
vim.keymap.set("v", "<leader>s", spectre.open_visual)

-- Search in current file
vim.keymap.set("n", "<leader>sp", "viw:lua require('spectre').open_file_search()<cr>")
