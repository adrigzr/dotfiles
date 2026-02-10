local augroup = vim.api.nvim_create_augroup("ftdetect_jsonc", {})

local jsonc_patterns = {
  "*.cjsn",
  "*.cjson",
  "*.jsonc",
  ".eslintrc.json",
  ".jshintrc",
  ".mocharc.json",
  ".mocharc.jsonc",
  "coc-settings.json",
  "coffeelint.json",
  "tsconfig.json",
  "*/waybar/config",
  "rush.json",
  "*/rush/*.json",
}

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = augroup,
  pattern = jsonc_patterns,
  callback = function()
    vim.bo.filetype = "jsonc"
  end,
})
