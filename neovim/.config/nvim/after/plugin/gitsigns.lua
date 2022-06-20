local exists, module = pcall(require, "gitsigns")

if not exists then
  return
end

module.setup {
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

    -- Navigation
    map("n", "]c", "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
    map("n", "[c", "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

    -- Actions
    map({ "n", "v" }, "<leader>hs", module.stage_hunk)
    map({ "n", "v" }, "<leader>hr", module.reset_hunk)
    map("n", "<leader>hS", module.stage_buffer)
    map("n", "<leader>hu", module.undo_stage_hunk)
    map("n", "<leader>hR", module.reset_buffer)
    map("n", "<leader>hp", module.preview_hunk)
    map("n", "<leader>hb", function()
      module.blame_line { full = true }
    end)
    -- map("n", "<leader>tb", module.toggle_current_line_blame)
    map("n", "<leader>hd", module.diffthis)
    map("n", "<leader>hD", function()
      module.diffthis "~"
    end)
    map("n", "<leader>ht", module.toggle_deleted)

    -- Text object
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
  end,
}
