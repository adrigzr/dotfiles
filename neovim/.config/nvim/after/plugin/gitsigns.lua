local exists, gitsigns = pcall(require, "gitsigns")

if not exists then
  return
end

local wk = require "which-key"
local misc = require "custom.util.misc"

gitsigns.setup {
  current_line_blame = true,
  current_line_blame_formatter_opts = {
    relative_time = true,
  },
  preview_config = {
    border = "rounded",
  },
  on_attach = function(bufnr)
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Visual mode
    wk.register({
      name = "GitSigns",
      s = { gitsigns.stage_hunk, "Stage the current hunk" },
      r = { gitsigns.reset_hunk, "Reset the current hunk" },
    }, { prefix = "<leader>h", buffer = bufnr, mode = "v" })

    -- Normal mode
    wk.register({
      name = "GitSigns",
      s = { gitsigns.stage_hunk, "Stage the current hunk" },
      r = { gitsigns.reset_hunk, "Reset the current hunk" },
      S = { gitsigns.stage_buffer, "Stage the current buffer" },
      u = { gitsigns.undo_stage_hunk, "Undo staging the current hunk" },
      R = { gitsigns.reset_buffer, "Reset the current buffer" },
      p = { gitsigns.preview_hunk, "Preview the current hunk" },
      b = { misc.bind(gitsigns.blame_line, { { full = true } }), "Blame the current line" },
      d = { gitsigns.diffthis, "Diff the current file against the index" },
      D = { misc.bind(gitsigns.diffthis, { "~" }), "Diff the current file against the last commit" },
      t = { gitsigns.toggle_deleted, "Toggle deleted lines" },
    }, { prefix = "<leader>h", buffer = bufnr })

    -- Navigation
    map("n", "]c", "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
    map("n", "[c", "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

    -- Text object
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
  end,
}
