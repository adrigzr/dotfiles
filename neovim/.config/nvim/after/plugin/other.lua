local exists, other = pcall(require, "other-nvim")

if not exists then
  return
end

other.setup {
  mappings = {
    {
      pattern = "/(.*)/(.*)%.(.*)$",
      target = {
        { target = "/%1/%2.\\(test\\|spec\\).%3", context = "test" },
        { target = "/%1/__tests__/%2.\\(test\\|spec\\).%3", context = "test" },
        { target = "/%1/__specs__/%2.\\(test\\|spec\\).%3", context = "test" },
      },
    },
    {
      pattern = "(.*)%.test%.(.*)$",
      target = "%1.%2",
      context = "main",
    },
    {
      pattern = "(.*)%.spec%.(.*)$",
      target = "%1.%2",
      context = "main",
    },
    {
      pattern = "/(.*)/__tests__/(.*)%.test%.(.*)$",
      target = "/%1/%2.%3",
      context = "main",
    },
    {
      pattern = "/(.*)/__specs__/(.*)%.spec%.(.*)$",
      target = "/%1/%2.%3",
      context = "main",
    },
  },
}

vim.keymap.set("n", "<leader>ff", "<cmd>Other<cr>", { desc = "Open alternate file" })
vim.keymap.set("n", "<leader>fs", "<cmd>OtherSplit<cr>", { desc = "Open alternate file in horizontal split" })
vim.keymap.set("n", "<leader>fv", "<cmd>OtherVSplit<cr>", { desc = "Open alternate file in vertical split" })
vim.keymap.set("n", "<leader>fc", "<cmd>OtherClear<cr>", { desc = "Clear references to alternate files" })
