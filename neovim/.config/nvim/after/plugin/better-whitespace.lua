if not vim.g.loaded_better_whitespace_plugin then
  return
end

local augroup = vim.api.nvim_create_augroup("betterwhitespace_config", {})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  command = "StripWhitespace",
})

vim.api.nvim_create_autocmd("ColorScheme", {
  group = augroup,
  callback = function()
    vim.api.nvim_set_hl(0, "ExtraWhitespace", { bg = "#e86671" })
  end,
})
