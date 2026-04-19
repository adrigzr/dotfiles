local ok, nts = pcall(require, "nvim-treesitter")
if not ok then
  return
end

nts.setup {
  install_dir = vim.fn.stdpath "data" .. "/site",
}

-- Idempotent: skips already-installed parsers. Runs asynchronously so it does
-- not block startup; first-time installs happen in the background.
nts.install {
  "bash",
  "c",
  "cmake",
  "css",
  "csv",
  "diff",
  "dockerfile",
  "git_config",
  "git_rebase",
  "gitcommit",
  "gitignore",
  "graphql",
  "html",
  "http",
  "javascript",
  "jsdoc",
  "json",
  "lua",
  "luadoc",
  "luap",
  "make",
  "markdown",
  "markdown_inline",
  "prisma",
  "python",
  "query",
  "regex",
  "ruby",
  "rust",
  "scss",
  "sql",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "vue",
  "xml",
  "yaml",
}

-- Custom `dotenv` parser registration is intentionally skipped in the initial
-- migration. The main-branch API for registering out-of-tree parsers is still
-- evolving. If dotenv highlighting is missed, re-introduce manual parser
-- installation into stdpath("data")/site/parser/dotenv.so with matching queries.

local ts_filetypes = {
  "bash",
  "c",
  "cmake",
  "css",
  "csv",
  "diff",
  "dockerfile",
  "gitcommit",
  "gitconfig",
  "gitignore",
  "gitrebase",
  "graphql",
  "html",
  "http",
  "javascript",
  "javascriptreact",
  "json",
  "jsonc",
  "lua",
  "make",
  "markdown",
  "prisma",
  "python",
  "query",
  "ruby",
  "rust",
  "scss",
  "sql",
  "toml",
  "tsx",
  "typescript",
  "typescriptreact",
  "vim",
  "help",
  "vue",
  "xml",
  "yaml",
}

local ts_group = vim.api.nvim_create_augroup("custom_treesitter", {})

-- Filetypes where the stock indentexpr is preferred over treesitter indent.
local disable_indent = { yaml = true }

vim.api.nvim_create_autocmd("FileType", {
  group = ts_group,
  pattern = ts_filetypes,
  callback = function(ev)
    -- Highlighting (no-op if parser missing).
    pcall(vim.treesitter.start, ev.buf)

    -- Treesitter indent (except filetypes where the stock indentexpr is better).
    if not disable_indent[vim.bo[ev.buf].filetype] then
      vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- Textobjects: explicit keymaps, no nested `keymaps = { ... }` table.
local ok_to, to = pcall(require, "nvim-treesitter-textobjects")
if not ok_to then
  return
end

to.setup {
  select = { lookahead = true },
  move = { set_jumps = true },
}

local tsobj_select = require "nvim-treesitter-textobjects.select"
local tsobj_move = require "nvim-treesitter-textobjects.move"
local tsobj_swap = require "nvim-treesitter-textobjects.swap"

local function ts_select(query)
  return function()
    tsobj_select.select_textobject(query, "textobjects")
  end
end

vim.keymap.set({ "x", "o" }, "af", ts_select "@function.outer", { desc = "Around function" })
vim.keymap.set({ "x", "o" }, "if", ts_select "@function.inner", { desc = "Inside function" })
vim.keymap.set({ "x", "o" }, "ac", ts_select "@class.outer", { desc = "Around class" })
vim.keymap.set({ "x", "o" }, "ic", ts_select "@class.inner", { desc = "Inside class" })
vim.keymap.set({ "x", "o" }, "aa", ts_select "@parameter.outer", { desc = "Around argument" })
vim.keymap.set({ "x", "o" }, "ia", ts_select "@parameter.inner", { desc = "Inside argument" })

vim.keymap.set("n", "]m", function()
  tsobj_move.goto_next_start("@function.outer", "textobjects")
end, { desc = "Next function start" })
vim.keymap.set("n", "]M", function()
  tsobj_move.goto_next_end("@function.outer", "textobjects")
end, { desc = "Next function end" })
vim.keymap.set("n", "[m", function()
  tsobj_move.goto_previous_start("@function.outer", "textobjects")
end, { desc = "Previous function start" })
vim.keymap.set("n", "[M", function()
  tsobj_move.goto_previous_end("@function.outer", "textobjects")
end, { desc = "Previous function end" })
vim.keymap.set("n", "]a", function()
  tsobj_move.goto_next_start("@parameter.inner", "textobjects")
end, { desc = "Next argument" })
vim.keymap.set("n", "[a", function()
  tsobj_move.goto_previous_start("@parameter.inner", "textobjects")
end, { desc = "Previous argument" })

vim.keymap.set("n", "<leader>sa", function()
  tsobj_swap.swap_next "@parameter.inner"
end, { desc = "Swap with next argument" })
vim.keymap.set("n", "<leader>sA", function()
  tsobj_swap.swap_previous "@parameter.inner"
end, { desc = "Swap with previous argument" })
