local exists, gitsigns = pcall(require, "gitsigns")

if not exists then
  return
end

local misc = require "custom.util.misc"

gitsigns.setup {
  current_line_blame = true,
  current_line_blame_formatter_opts = {
    relative_time = true,
  },
  preview_config = {
    border = "rounded",
  },
  watch_gitdir = {
    enabled = false,
  },
  on_attach = function(bufnr)
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Commands
    map({ "n", "v" }, "<leader>hs", gitsigns.stage_hunk, { desc = "Stage the current hunk" })
    map({ "n", "v" }, "<leader>hr", gitsigns.reset_hunk, { desc = "Reset the current hunk" })
    map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage the current buffer" })
    map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Undo staging the current hunk" })
    map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset the current buffer" })
    map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview the current hunk" })
    map("n", "<leader>hb", misc.bind(gitsigns.blame_line, { { full = true } }), { desc = "Blame the current line" })
    map("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff the current file against the index" })
    map("n", "<leader>ht", gitsigns.toggle_deleted, { desc = "Toggle deleted lines" })
    map(
      "n",
      "<leader>hD",
      misc.bind(gitsigns.diffthis, { "~" }),
      { desc = "Diff the current file against the last commit" }
    )

    -- Navigation
    map("n", "]c", "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true, desc = "Go to next hunk" })
    map("n", "[c", "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true, desc = "Go to previous hunk" })

    -- Text object
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
  end,
}
