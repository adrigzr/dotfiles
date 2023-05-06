local exists, module = pcall(require, "nvim-autopairs")

if not exists then
  return
end

module.setup {
  check_ts = true,
  fast_wrap = {
    map = "<c-q>",
  },
  disable_filetype = { "TelescopePrompt", "vim" },
}
