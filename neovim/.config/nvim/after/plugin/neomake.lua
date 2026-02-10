if not vim.g.loaded_neomake then
  return
end

vim.keymap.set("n", "<leader>mm", "<cmd>Neomake!<cr>", { desc = "Make project" })
vim.keymap.set("n", "<leader>mf", "<cmd>Neomake<cr>", { desc = "Make file" })

local trouble = require "trouble"
local augroup = vim.api.nvim_create_augroup("NeomakeGroup", {})

vim.api.nvim_create_autocmd("User", {
  pattern = "NeomakeFinished",
  group = augroup,
  callback = function()
    local qflist = vim.fn.getqflist { all = true }
    local loclist = vim.fn.getloclist(0, { all = true })
    local mode = not vim.tbl_isempty(qflist.items) and "quickfix"
      or not vim.tbl_isempty(loclist.items) and "loclist"
      or nil

    if mode then
      trouble.open { mode = mode }
    else
      trouble.close()
    end
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "NeomakeJobFinished",
  group = augroup,
  callback = function()
    local context = vim.g.neomake_hook_context

    if context.jobinfo.exit_code ~= 0 then
      vim.notify("'" .. context.jobinfo.name .. "' failed!", vim.log.levels.ERROR, {
        title = "Neomake",
      })
    else
      vim.notify("'" .. context.jobinfo.name .. "' successful!", vim.log.levels.INFO, {
        title = "Neomake",
      })
    end
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "NeomakeJobStarted",
  group = augroup,
  callback = function()
    local context = vim.g.neomake_hook_context

    vim.notify("Running '" .. context.jobinfo.name .. "'...", vim.log.levels.INFO, {
      title = "Neomake",
    })
  end,
})
