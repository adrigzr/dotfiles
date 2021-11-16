local exists, module = pcall(require, "gitsigns")

if not exists then
  return
end

module.setup {
  current_line_blame = true,
  current_line_blame_formatter_opts = {
    relative_time = true,
  },
  preview_config = {
    border = 'rounded',
  },
}
