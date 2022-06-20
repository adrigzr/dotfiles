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

--- Show a prompt to select a process pid
function M.pick_process()
  local separator = " \\+"
  local command = "ps a | sed 1d"
  -- output format for ps ah
  --    " 107021 pts/4    Ss     0:00 /bin/zsh <args>"
  local get_pid = function(parts)
    return parts[1]
  end

  local get_process_name = function(parts)
    return table.concat({ unpack(parts, 5) }, " ")
  end

  local output = vim.fn.system(command)
  local lines = vim.split(output, "\n")
  local procs = {}

  for _, line in pairs(lines) do
    if line ~= "" then -- tasklist command outputs additional empty line in the end
      local parts = vim.fn.split(vim.fn.trim(line), separator)
      local pid, name = get_pid(parts), get_process_name(parts)
      pid = tonumber(pid)
      if pid ~= vim.fn.getpid() then
        table.insert(procs, { pid = pid, name = name })
      end
    end
  end

  local label_fn = function(proc)
    return string.format("id=%d name=%s", proc.pid, proc.name)
  end

  local result = require("dap.ui").pick_one_sync(procs, "Select process", label_fn)

  return result and result.pid or nil
end

return M
