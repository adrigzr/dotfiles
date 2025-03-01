local exists, module = pcall(require, "copilot")

if not exists then
  return
end

module.setup {
  suggestion = {
    auto_trigger = true,
  },
}

local suggestion = require "copilot.suggestion"

vim.keymap.set("i", "‘", suggestion.next, { noremap = false })
vim.keymap.set("i", "“", suggestion.prev, { noremap = false })
vim.keymap.set("i", "«", suggestion.next, { noremap = false })
