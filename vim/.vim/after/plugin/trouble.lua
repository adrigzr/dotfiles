local exists, module = pcall(require, "trouble")

if not exists then
  return
end

module.setup {
  use_lsp_diagnostic_signs = true,
}
