vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("mini_trailspace_blacklist", {}),
  pattern = {
    "DiffviewFileHistory",
    "DiffviewFiles",
    "dashboard",
    "diff",
    "fugitive",
    "git",
    "gitcommit",
    "help",
    "lazy",
    "markdown",
    "qf",
    "snacks_dashboard",
    "unite",
  },
  callback = function()
    vim.b.minitrailspace_disable = true
  end,
})
