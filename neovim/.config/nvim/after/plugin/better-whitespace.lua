local exists, trailspace = pcall(require, "mini.trailspace")

if not exists then
  return
end

trailspace.setup()

local augroup = vim.api.nvim_create_augroup("mini_trailspace_config", {})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  callback = function()
    if not vim.b.minitrailspace_disable then
      trailspace.trim()
    end
  end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
  group = augroup,
  callback = function()
    vim.api.nvim_set_hl(0, "MiniTrailspace", { bg = "#e86671" })
  end,
})

-- Snacks dashboard sets buftype/filetype with eventignore="all", so the
-- FileType event never fires and the blacklist autocmd never runs.
-- Explicitly disable highlighting when the dashboard opens.
vim.api.nvim_create_autocmd("User", {
  group = augroup,
  pattern = "SnacksDashboardOpened",
  callback = function()
    vim.b.minitrailspace_disable = true
    trailspace.unhighlight()
  end,
})
