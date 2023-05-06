local exists, module = pcall(require, "pretty-fold")

if not exists then
  return
end

module.setup {
  comment_signs = false,
}

require("pretty-fold.preview").setup_keybinding()
