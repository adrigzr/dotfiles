if not vim.g.loaded_vader then
  return
end

local function exercism_tests()
  local ext = vim.fn.expand "%:e"

  if ext == "vim" then
    local testfile = string.format("%s/%s.vader", vim.fn.expand "%:p:h", vim.fn.expand("%:p:h:t"):gsub("-", "_"))

    if vim.fn.filereadable(testfile) == 0 then
      vim.api.nvim_err_writeln("File does not exist: " .. testfile)
      return
    end

    vim.cmd "source %"
    vim.cmd("Vader " .. testfile)
  else
    local sourcefile = string.format("%s/%s.vim", vim.fn.expand "%:p:h", vim.fn.expand("%:p:h:t"):gsub("-", "_"))

    if vim.fn.filereadable(sourcefile) == 0 then
      vim.api.nvim_err_writeln("File does not exist: " .. sourcefile)
      return
    end

    vim.cmd("source " .. sourcefile)
    vim.cmd "Vader"
  end
end

local augroup = vim.api.nvim_create_augroup("vader", {})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup,
  pattern = { "*.vader", "*.vim" },
  callback = function()
    vim.api.nvim_buf_create_user_command(0, "Test", function()
      exercism_tests()
    end, {})
  end,
})
