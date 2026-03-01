local exists, diffview = pcall(require, "diffview")

if not exists then
  return
end

diffview.setup {
  enhanced_diff_hl = true,
  view = {
    merge_tool = {
      layout = "diff3_horizontal",
      disable_diagnostics = true,
      winbar_info = true,
    },
  },
}
