local exists, module = pcall(require, "refactoring")

if not exists then
  return
end

module.setup {}

require("telescope").load_extension "refactoring"

vim.keymap.set(
  "v",
  "<leader>cr",
  "<esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
  { desc = "Apply refactoring" }
)
