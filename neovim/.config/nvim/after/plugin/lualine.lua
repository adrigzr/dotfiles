local exists, module = pcall(require, "lualine")

if not exists then
  return
end

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = {
    error = "",
    warn = "",
    info = "",
    hint = "",
  },
}

local diff = {
  "diff",
  source = function()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
      return {
        added = gitsigns.added,
        modified = gitsigns.changed,
        removed = gitsigns.removed,
      }
    end
  end,
}

local encoding = {
  "encoding",
  cond = function()
    return vim.bo.fileencoding ~= "utf-8"
  end,
}

local fileformat = {
  "fileformat",
  cond = function()
    return vim.bo.fileformat ~= "unix"
  end,
}

local lsp_clients = {
  function()
    local clients = vim.lsp.get_clients { bufnr = 0 }
    if #clients == 0 then
      return ""
    end
    local names = {}
    for _, c in ipairs(clients) do
      table.insert(names, c.name)
    end
    return table.concat(names, ", ")
  end,
  icon = " ",
}

local codecompanion_status = require "custom.lualine.codecompanion"

local opencode_status = {
  function()
    return require("opencode").statusline()
  end,
  cond = function()
    local ok, opencode = pcall(require, "opencode")
    return ok and opencode.statusline() ~= ""
  end,
}

local code_reviewer_status = {
  function()
    return require("code-reviewer").lualine_status()
  end,
  cond = function()
    local ok, code_review = pcall(require, "code-reviewer")
    return ok and code_review.lualine_status() ~= ""
  end,
}

module.setup {
  options = {
    icons_enabled = true,
    theme = "onedark",
    component_separators = "",
    section_separators = "",
    disabled_filetypes = {},
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", diagnostics, diff },
    lualine_c = {},
    lualine_x = {
      opencode_status,
      codecompanion_status,
      code_reviewer_status,
      lsp_clients,
      encoding,
    },
    lualine_y = { fileformat, "filetype" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = { "encoding", "fileformat", "filetype", "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = { "quickfix", "fugitive", "nvim-tree", "nvim-dap-ui", "man", "lazy", "trouble" },
}
