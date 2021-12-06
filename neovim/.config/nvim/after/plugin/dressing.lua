local exists, module = pcall(require, "dressing")

if not exists then
  return
end

module.setup {
  input = {
    default_prompt = "➜ ",
  },
  select = {
    telescope = {
      theme = "cursor",
    },
  },
}
