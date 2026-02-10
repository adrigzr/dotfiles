local map = vim.keymap.set

-- Disable arrow keys
map("n", "<Up>", "<NOP>")
map("n", "<Down>", "<NOP>")
map("n", "<Left>", "<NOP>")
map("n", "<Right>", "<NOP>")

-- Save / sudo write
map("n", "<leader>w", ":w<CR>", { desc = "Save file" })
map("n", "<leader>W", ":w !sudo tee %<CR>", { desc = "Sudo save file" })

-- Shell command output
vim.api.nvim_create_user_command("R", function(opts)
  vim.cmd "new"
  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "hide"
  vim.bo.swapfile = false
  vim.cmd("r !" .. opts.args)
end, { nargs = "*", complete = "shellcmd" })

-- Remap :W to :w
vim.api.nvim_create_user_command("W", "w", {})

-- Better mark jumping (line + col)
map("n", "'", "`")

-- Clear last search
map("n", "<leader>qs", ":noh<CR>", { silent = true, desc = "Clear search highlight" })

-- Edit near files
map("n", "ge", ":e %:h", { desc = "Edit near files" })

-- Reselect pasted text
map("n", "gp", "`[v`]", { desc = "Reselect pasted text" })

-- Insert newline
map("n", "<leader><Enter>", "o<ESC>", { desc = "Insert newline below" })

-- Search and replace word under cursor
map("n", "<leader>*", [[:%s/\<<C-r><C-w>\>//<Left>]], { desc = "Replace word under cursor" })
map("v", "<leader>*", [["hy:%s/\V<C-r>h//<left>]], { desc = "Replace selection" })

-- Join lines and restore cursor location
map("n", "J", "mjJg`j:delmarks j<CR>", { desc = "Join lines" })

-- Remap logical movement to visual
map("n", "j", function()
  return vim.v.count > 0 and "j" or "gj"
end, { expr = true })
map("n", "k", function()
  return vim.v.count > 0 and "k" or "gk"
end, { expr = true })
map("n", "gj", "j")
map("n", "gk", "k")

-- Fix page up and down
map("", "<PageUp>", "<C-U>")
map("", "<PageDown>", "<C-D>")

-- Search current selection
map("v", "//", [[y/\V<C-R>"<CR>N]], { desc = "Search selection forward" })
map("v", "??", [[y?\V<C-R>"<CR>]], { desc = "Search selection backward" })

-- Move line (C-Up) (C-Down)
map("n", "[1;5A", "mz:m-2<CR>`z==")
map("n", "[1;5B", "mz:m+<CR>`z==")
map("i", "[1;5A", "<Esc>:m-2<CR>==gi")
map("i", "[1;5B", "<Esc>:m+<CR>==gi")
map("v", "[1;5A", ":'<,'>m'<-2<CR>gv=`>my`<mzgv`yo`z")
map("v", "[1;5B", ":'<,'>m'>+<CR>gv=`<my`>mzgv`yo`z")

-- Buffers
map("n", "<leader>bs", ":Telescope buffers<CR>", { desc = "List buffers" })
map("n", "<leader>bt", ":enew<CR>", { desc = "New buffer" })
map("n", "<leader>bd", ":Bdelete<CR>", { desc = "Delete buffer" })
map("n", "<leader>bD", ":bufdo :Bdelete<CR>", { desc = "Delete all buffers" })
map("n", "<leader><leader>", "<c-^>", { desc = "Alternate buffer" })

-- Quickfix window
map("n", "<leader>qq", ":cclose<CR>", { desc = "Close quickfix" })
map("n", "<leader>qo", ":copen<CR>", { desc = "Open quickfix" })
map("n", "<leader>qj", ":cnext<CR>", { desc = "Next quickfix" })
map("n", "<leader>qk", ":cprev<CR>", { desc = "Previous quickfix" })
map("n", "<leader>qc", ":cc<CR>", { desc = "Current quickfix" })

-- Location list window
map("n", "<leader>lq", ":lclose<CR>", { desc = "Close location list" })
map("n", "<leader>lo", ":lopen<CR>", { desc = "Open location list" })
map("n", "<leader>lj", ":lnext<CR>", { desc = "Next location" })
map("n", "<leader>lk", ":lprev<CR>", { desc = "Previous location" })
map("n", "<leader>ll", ":ll<CR>", { desc = "Current location" })

-- Preview window
map("n", "<leader>pq", ":pclose<CR>", { desc = "Close preview" })
map("n", "<leader>pj", ":ptnext<CR>", { desc = "Next preview" })
map("n", "<leader>pk", ":ptprevious<CR>", { desc = "Previous preview" })

-- Move lines
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
map("i", "<c-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
map("i", "<c-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
map("n", "<leader>k", ":m .-2<CR>==", { desc = "Move line up" })
map("n", "<leader>j", ":m .+1<CR>==", { desc = "Move line down" })

-- Text Objects

-- "in line"
map({ "x", "o" }, "il", function()
  vim.cmd "normal! g_v^"
end, { silent = true, desc = "In line" })

-- "around line"
map({ "x", "o" }, "al", function()
  vim.cmd "normal! $v0"
end, { silent = true, desc = "Around line" })

-- "inner document"
map("x", "id", function()
  vim.cmd "normal! G$Vgg0"
end, { silent = true, desc = "Inner document" })
map("o", "id", function()
  vim.cmd "normal! GVgg"
end, { silent = true, desc = "Inner document" })

-- "in number" / "around number"
-- Matches binary (0b1010), hex (0xffff), and decimal numbers
local reg_nums = { "0b[01]", "0x%x", "%d" }

local function in_number()
  local line_nr = vim.fn.line "."
  local pat = table.concat(
    vim.tbl_map(function(r)
      return r .. "+"
    end, reg_nums),
    "\\|"
  )

  if vim.fn.search(pat, "ce", line_nr) == 0 then
    return
  end

  vim.cmd "normal! v"
  vim.fn.search(pat, "cb", line_nr)
end

local function around_number()
  local line_nr = vim.fn.line "."
  local pat = table.concat(
    vim.tbl_map(function(r)
      return r .. "+"
    end, reg_nums),
    "\\|"
  )

  if vim.fn.search(pat, "ce", line_nr) == 0 then
    return
  end

  vim.fn.search("\\%" .. (vim.fn.virtcol "." + 1) .. "v\\s*", "ce", line_nr)
  vim.cmd "normal! v"
  vim.fn.search(pat, "cb", line_nr)
  vim.fn.search("\\s*\\%" .. vim.fn.virtcol "." .. "v", "b", line_nr)
end

map({ "x", "o" }, "in", in_number, { silent = true, desc = "In number" })
map({ "x", "o" }, "an", around_number, { silent = true, desc = "Around number" })

-- "in indentation" / "around indentation"
local function in_indentation()
  vim.cmd "normal! ^"
  local line = vim.fn.getline "."
  local v_col = vim.fn.virtcol(line:match "^%s*$" and "$" or ".")
  local pat = "^\\(\\s*\\%" .. v_col .. "v\\|^$\\)\\@!"

  local start_line = vim.fn.search(pat, "bWn") + 1
  local end_line = vim.fn.search(pat, "Wn")

  if end_line ~= 0 then
    end_line = end_line - 1
  end

  vim.cmd("normal! " .. start_line .. "G0")
  vim.fn.search("^[^\n\r]", "Wc")
  vim.cmd("normal! Vo" .. end_line .. "G")
  vim.fn.search("^[^\n\r]", "bWc")
  vim.cmd "normal! $o"
end

local function around_indentation()
  vim.cmd "normal! ^"
  local line = vim.fn.getline "."
  local v_col = vim.fn.virtcol(line:match "^%s*$" and "$" or ".")
  local pat = "^\\(\\s*\\%" .. v_col .. "v\\|^$\\)\\@!"

  local start_line = vim.fn.search(pat, "bWn") + 1
  local end_line = vim.fn.search(pat, "Wn")

  if end_line ~= 0 then
    end_line = end_line - 1
  end

  vim.cmd("normal! " .. start_line .. "G0V" .. end_line .. "G$o")
end

map({ "x", "o" }, "ii", in_indentation, { silent = true, desc = "In indentation" })
map({ "x", "o" }, "ai", around_indentation, { silent = true, desc = "Around indentation" })
