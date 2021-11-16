local exists, module = pcall(require, "indent_blankline")

if not exists then
  return
end

module.setup {
  show_end_of_line = true,
  space_char_blankline = " ",
  show_current_context = true,
  filetype_exclude = { "dashboard", "lsp-installer", "lsp-info", "NvimTree", "packer" },
}
