local M = {}

-- Try to load a module
function M.prequire(module)
  local ok, mod = pcall(require, module)

  if not ok then
    mod = nil
  end

  return mod
end

-- List all floating windows attached to the current buffer
function M.get_floating_windows()
  local list_wins = vim.api.nvim_list_wins()
  local current_win = vim.api.nvim_get_current_win()

  return vim.tbl_filter(function(v)
    local config = vim.api.nvim_win_get_config(v)

    return config.relative == "win" and config.win == current_win
  end, list_wins)
end

-- List all floating windows attached to the current buffer
function M.check_floating_windows()
  local ok, existing_float = pcall(vim.api.nvim_buf_get_var, 0, "lsp_floating_preview")

  return ok and vim.api.nvim_win_is_valid(existing_float)
end

-- Get current mode
function M.get_mode()
  local tbl = vim.api.nvim_get_mode()

  return tbl.mode
end

-- Check if prev character is a space
function M.has_space_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))

  return col == 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s"
end

-- Check if previou character is not a space
function M.has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))

  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

-- Convert an array into a truth table
--
-- Example:
--  { 'foo' } => { ['foo'] = true }
function M.array_to_table(a)
  local t = {}

  for _, v in pairs(a) do
    t[v] = true
  end

  return t
end

return M
