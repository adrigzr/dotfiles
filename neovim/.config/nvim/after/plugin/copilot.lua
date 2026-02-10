local exists, module = pcall(require, "copilot")

if not exists then
  return
end

module.setup {
  filetypes = {
    yaml = true,
  },
  suggestion = {
    auto_trigger = true,
    keymap = {
      accept = false,
      accept_word = false,
      accept_line = false,
      next = "<C-]>",
      prev = "<C-}>",
      dismiss = false,
    },
  },
}

local suggestion = require "copilot.suggestion"

vim.keymap.set("i", "‘", suggestion.next, { noremap = false })
vim.keymap.set("i", "“", suggestion.prev, { noremap = false })
vim.keymap.set("i", "«", suggestion.next, { noremap = false })
