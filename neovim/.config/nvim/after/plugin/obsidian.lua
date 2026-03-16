local exists, obsidian = pcall(require, "obsidian")

if not exists then
  return
end

obsidian.setup {
  workspaces = {
    {
      name = "aircall",
      path = "~/Documents/Aircall Vault",
    },
    {
      name = "homelab",
      path = "~/Documents/Homelab Vault",
    },
  },

  -- Use snacks.picker for all picker-based commands
  picker = { name = "snacks.pick" },

  -- Use human-readable filenames (matching Obsidian app default)
  note_id_func = function(title)
    if title ~= nil then
      return title
    end

    -- If no title is given, generate a 4-char suffix
    local suffix = ""

    for _ = 1, 4 do
      suffix = suffix .. string.char(math.random(65, 90))
    end

    return tostring(os.time()) .. "-" .. suffix
  end,

  -- Disable legacy commands (will be removed in next major release)
  legacy_commands = false,

  -- Keymaps
  keys = {
    smart_action = {
      n = "<CR>",
    },
  },
}

local map = vim.keymap.set

map("n", "<leader>oo", "<cmd>Obsidian quick_switch<cr>", { desc = "Obsidian quick switch" })
map("n", "<leader>os", "<cmd>Obsidian search<cr>", { desc = "Obsidian search" })
map("n", "<leader>ot", "<cmd>Obsidian today<cr>", { desc = "Obsidian today" })
map("n", "<leader>od", "<cmd>Obsidian dailies<cr>", { desc = "Obsidian dailies" })
map("n", "<leader>on", "<cmd>Obsidian new<cr>", { desc = "Obsidian new note" })
map("n", "<leader>ob", "<cmd>Obsidian backlinks<cr>", { desc = "Obsidian backlinks" })
map("n", "<leader>ol", "<cmd>Obsidian links<cr>", { desc = "Obsidian links" })
map("n", "<leader>og", "<cmd>Obsidian tags<cr>", { desc = "Obsidian tags" })
map("n", "<leader>oi", "<cmd>Obsidian paste_img<cr>", { desc = "Obsidian paste image" })
map("n", "<leader>oe", "<cmd>Obsidian template<cr>", { desc = "Obsidian insert template" })
map("n", "<leader>ow", "<cmd>Obsidian workspace<cr>", { desc = "Obsidian switch workspace" })
map("v", "<leader>ok", "<cmd>Obsidian link<cr>", { desc = "Obsidian link selection" })
map("v", "<leader>ox", "<cmd>Obsidian extract_note<cr>", { desc = "Obsidian extract note" })
