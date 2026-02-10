if vim.g.loaded_term_startinsert then
  return
end

vim.g.loaded_term_startinsert = 1

local augroup = vim.api.nvim_create_augroup("term_startinsert", {})

vim.api.nvim_create_autocmd("TermOpen", {
  group = augroup,
  command = "startinsert",
})
