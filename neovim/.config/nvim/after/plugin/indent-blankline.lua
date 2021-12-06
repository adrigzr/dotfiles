local exists, module = pcall(require, "indent_blankline")

if not exists then
  return
end

module.setup {
  show_end_of_line = true,
  show_current_context = true,
  filetype_exclude = {
    "dashboard",
    "lsp-installer",
    "lspinfo",
    "NvimTree",
    "packer",
    "help",
  },
}
