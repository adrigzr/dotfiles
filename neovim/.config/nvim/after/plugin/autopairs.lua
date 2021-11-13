local exists, module = pcall(require, "nvim-autopairs")

if not exists then
  return
end

module.setup {
  disable_filetype = { "TelescopePrompt" , "vim" },
}
