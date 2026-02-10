local exists, wk = pcall(require, "which-key")

if not exists then
  return
end

wk.setup {
  win = {
    height = { min = 4, max = 15 },
    width = { min = 20, max = 50 },
    padding = { 1, 2 },
  },
  layout = {
    spacing = 3,
    align = "left",
  },
}
