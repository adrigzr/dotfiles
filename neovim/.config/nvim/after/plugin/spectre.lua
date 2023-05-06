local exists, spectre = pcall(require, "spectre")

if not exists then
  return
end

local bind = require("custom.util.misc").bind
local map = vim.keymap.set

-- Open spectre
map("n", "<leader>ss", spectre.open, { desc = "Open spectre" })

-- Search current word
map("n", "<leader>sw", bind(spectre.open_visual, { { select_word = true } }), { desc = "Search current word" })
map("v", "<leader>s", spectre.open_visual, { desc = "Search current word" })

-- Search in current file
map("n", "<leader>sp", "viw:lua require('spectre').open_file_search()<cr>", { desc = "Search in current file" })
