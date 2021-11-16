local exists, module = pcall(require, "treesitter-context")

if not exists then
  return
end

module.setup {
  patterns = {
    json = {
      'pair'
    }
  }
}
