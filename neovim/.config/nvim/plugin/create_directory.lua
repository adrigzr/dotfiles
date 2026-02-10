if vim.g.loaded_create_directory then
  return
end

vim.g.loaded_create_directory = 1

local augroup = vim.api.nvim_create_augroup("create_directory", {})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  callback = function(args)
    local buftype = vim.bo[args.buf].buftype

    if buftype ~= "" then
      return
    end

    local file = args.file

    if file:match "^%w+://" then
      return
    end

    local dir = vim.fn.fnamemodify(file, ":h")

    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
})
