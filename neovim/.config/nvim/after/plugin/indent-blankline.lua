local exists, module = pcall(require, "ibl")

if not exists then
  return
end

module.setup {
  exclude = {
    filetypes = {
      "dashboard",
      "lsp-installer",
      "lspinfo",
      "NvimTree",
      "packer",
      "help",
    },
  },
}
