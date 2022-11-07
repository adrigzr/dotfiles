local exists, telescope = pcall(require, "telescope")

if not exists then
  return
end

local actions = require "telescope.actions"
local trouble = require "trouble"
local map = vim.keymap.set

vim.cmd [[
  nnoremap <C-p> <cmd>Telescope find_files<cr>
  nnoremap <C-g> <cmd>Telescope live_grep<cr>
  nnoremap gb    <cmd>Telescope buffers<cr>
]]

-- Mappings
map("n", "<C-p>", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<C-g>", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
map("n", "gb", "<cmd>Telescope buffers<cr>", { desc = "Find in buffers" })
map("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Find branches" })
map("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Find commits" })
map("n", "<leader>gd", "<cmd>Telescope git_bcommits<cr>", { desc = "Find commits in current branch" })
map("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Find in staged files" })
map("n", "<leader>gl", "<cmd>G log<cr>", { desc = "Show git log" })

local results_with_preview = {
  layout_strategy = "vertical",
  layout_config = { width = 0.9 },
  fname_width = 0.5,
  trim_text = true,
}

telescope.setup {
  defaults = {
    prompt_prefix = "➜ ",
    selection_caret = "➜ ",
    mappings = {
      -- Mapping <Esc> to quit in insert mode
      i = {
        ["<esc>"] = actions.close,
        ["<c-n>"] = actions.cycle_history_next,
        ["<c-p>"] = actions.cycle_history_prev,
        ["<c-t>"] = trouble.open_with_trouble,
      },
    },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
    },
  },
  pickers = {
    find_files = {
      hidden = true,
      find_command = {
        "rg",
        "--files",
        "--hidden",
        "--follow",
        "--glob",
        "!.git/*",
        "--glob",
        "!node_modules/*",
      },
    },
    buffers = {
      ignore_current_buffer = true,
      sort_mru = true,
      sort_lastused = true,
    },
    lsp_references = vim.tbl_deep_extend("force", results_with_preview, {
      include_declaration = false,
    }),
    lsp_type_definitions = vim.tbl_deep_extend("force", results_with_preview, {}),
    lsp_implementations = vim.tbl_deep_extend("force", results_with_preview, {}),
    live_grep = vim.tbl_deep_extend("force", results_with_preview, {
      glob_pattern = { "!.git", "!node_modules/*", "!yarn.lock" },
      disable_coordinates = true,
    }),
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    media_files = {
      find_cmd = "rg",
    },
  },
}

telescope.load_extension "fzf"
telescope.load_extension "dap"
