vim.opt_local.formatprg = "shfmt -bn -ci"

vim.b.undo_ftplugin = (vim.b.undo_ftplugin or "") .. "|setlocal formatprg<"
