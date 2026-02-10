local exists, module = pcall(require, "dressing")

if not exists then
  return
end

module.setup {
  input = {
    default_prompt = "➜ ",
    insert_only = false,
    prefer_width = 80,
    max_width = 120,
    min_width = 60,
  },
  select = {
    telescope = require("telescope.themes").get_cursor(),
  },
}
