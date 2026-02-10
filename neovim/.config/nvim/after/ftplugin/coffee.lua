vim.opt_local.foldmethod = "indent"

vim.b.undo_ftplugin = (vim.b.undo_ftplugin or "") .. "|setlocal foldmethod<"
