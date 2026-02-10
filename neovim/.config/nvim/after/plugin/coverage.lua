local exists, coverage = pcall(require, "coverage")

if not exists then
  return
end

coverage.setup {
  signs = {
    covered = { text = "▕" },
    uncovered = { text = "▕" },
  },
}

local augroup = vim.api.nvim_create_augroup("NeomakeCustomGroup", {})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.ts",
  group = augroup,
  callback = function()
    if not require("coverage.report").is_cached() then
      return coverage.load(true)
    end

    local filetype = vim.bo.filetype
    local report = require("coverage.report").get()
    local sign_list = require("coverage.languages." .. filetype).sign_list(report)

    require("coverage.signs").place(sign_list)
  end,
})
