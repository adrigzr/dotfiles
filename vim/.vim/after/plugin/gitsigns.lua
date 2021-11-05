local exists, module = pcall(require, "gitsigns")

if not exists then
  return
end

module.setup {
  current_line_blame = true
}
