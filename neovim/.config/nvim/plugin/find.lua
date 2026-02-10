if vim.g.loaded_find or vim.fn.executable "rg" == 0 then
  return
end

vim.g.loaded_find = 1

vim.opt.grepprg = "rg --no-heading --vimgrep --smart-case --color=never --ignore-case --hidden --glob !.git"
vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"

vim.api.nvim_create_user_command("Find", function(opts)
  vim.cmd("silent grep! " .. opts.args)
  vim.cmd "copen"
  vim.cmd "redraw!"
end, { nargs = "+", complete = "dir" })
