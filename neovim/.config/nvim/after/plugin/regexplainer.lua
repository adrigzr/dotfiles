local exists, module = pcall(require, "regexplainer")

if not exists then
  return
end

module.setup {
  mode = "narrative",
  auto = false,
  debug = false,
  display = "popup",
  mappings = {
    show = "gR",
  },
  narrative = {
    separator = "\n",
  },
}
