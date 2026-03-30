if vim.g.loaded_jinja then
  return
end

vim.g.loaded_jinja = 1

local augroup = vim.api.nvim_create_augroup("jinja_highlight", {})

local function apply_jinja_highlights(winid)
  -- Avoid duplicate matches in the same window.
  if vim.w[winid].jinja_matches then
    return
  end

  vim.api.nvim_win_call(winid, function()
    vim.fn.matchadd("Comment", "{#.\\{-}#}")
    vim.fn.matchadd("Special", "{{.\\{-}}}")
    vim.fn.matchadd("PreProc", "{%.\\{-}%}")
  end)

  vim.w[winid].jinja_matches = true
end

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = augroup,
  callback = function(args)
    if vim.b[args.buf].is_jinja then
      apply_jinja_highlights(vim.api.nvim_get_current_win())
    end
  end,
})
