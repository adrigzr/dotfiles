if vim.g.loaded_restore_cursor then
  return
end

vim.g.loaded_restore_cursor = 1

local augroup = vim.api.nvim_create_augroup("restore_cursor", {})

vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)

    if mark[1] > 1 and mark[1] <= line_count then
      vim.cmd 'normal! g`"'
    end
  end,
})
