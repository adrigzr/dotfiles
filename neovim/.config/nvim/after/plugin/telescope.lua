local exists, module = pcall(require, "telescope")

if not exists then
  return
end

local actions = require "telescope.actions"

vim.cmd [[
  nnoremap <C-p> <cmd>Telescope find_files<cr>
  nnoremap gb    <cmd>Telescope buffers<cr>
]]

module.setup {
  defaults = {
    prompt_prefix = "➜ ",
    selection_caret = "➜ ",
    mappings = {
      -- Mapping <Esc> to quit in insert mode
      i = {
        ["<esc>"] = actions.close,
        ["<c-n>"] = actions.cycle_history_next,
        ["<c-p>"] = actions.cycle_history_prev,
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
        "--glob",
        "!.git/*",
        "--glob",
        "!.lint-todo/*",
        "--glob",
        "!recordings/*",
        "--glob",
        "!node_modules/*",
        "--follow",
      },
    },
    buffers = {
      ignore_current_buffer = true,
      sort_mru = true,
      sort_lastused = true,
    },
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

module.load_extension "fzf"
