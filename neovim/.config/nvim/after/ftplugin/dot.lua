vim.opt_local.makeprg = "dot -Tsvg \"%:p\" -o \"%:p:r.svg\""

vim.b.undo_ftplugin = (vim.b.undo_ftplugin or "") .. "|setlocal makeprg<"
