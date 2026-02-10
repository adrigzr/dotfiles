if vim.g.did_load_commands then
  return
end

vim.g.did_load_commands = 1

-- Format json
vim.api.nvim_create_user_command("FormatJSON", function()
  vim.cmd "%!python -m json.tool"
end, {})

-- Copy current file path
vim.api.nvim_create_user_command("CopyPath", function()
  vim.fn.setreg("+", vim.fn.expand "%")
end, {})
