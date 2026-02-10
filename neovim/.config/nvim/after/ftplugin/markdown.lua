vim.opt_local.wrap = true
vim.opt_local.formatoptions = "t1"
vim.opt_local.expandtab = false
vim.opt_local.linebreak = true
vim.opt_local.smartindent = true
vim.opt_local.synmaxcol = 3000
vim.opt_local.display = "lastline"

vim.b.undo_ftplugin = (vim.b.undo_ftplugin or "")
  .. "|setlocal wrap<"
  .. "|setlocal formatoptions<"
  .. "|setlocal expandtab<"
  .. "|setlocal linebreak<"
  .. "|setlocal smartindent<"
  .. "|setlocal synmaxcol<"
  .. "|setlocal display<"

if vim.fn.has "spell" == 1 and vim.bo.modifiable and not vim.bo.readonly then
  vim.opt_local.spell = true
  vim.b.undo_ftplugin = vim.b.undo_ftplugin .. "|setlocal spell<"
end
