local exists, hydra = pcall(require, "hydra")

if not exists then
  return
end

local hint = [[
  _h_, _l_: ←/→     _H_, _L_: half screen ←/→     _<Esc>_: exit
]]

hydra {
  hint = hint,
  name = "Side scroll",
  config = {
    hint = { border = "rounded" },
  },
  mode = "n",
  body = "z",
  heads = {
    { "h", "5zh" },
    { "l", "5zl", { desc = "←/→" } },
    { "H", "zH" },
    { "L", "zL", { desc = "half screen ←/→" } },
  },
}
