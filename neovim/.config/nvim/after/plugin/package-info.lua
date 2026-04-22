local exists, package_info = pcall(require, "package-info")
if not exists then
  return
end

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "package.json",
  callback = function()
    -- WHY: package-info.nvim's built-in BufEnter autocmd crashes when
    -- diffview.nvim opens a virtual buffer (diffview:// URI) for package.json,
    -- because the derived cwd is not a valid filesystem directory.
    local bufname = vim.api.nvim_buf_get_name(0)
    if bufname:match "^diffview://" then
      return
    end
    package_info.show()
  end,
})
