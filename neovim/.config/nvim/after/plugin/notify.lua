local exists, notify = pcall(require, "notify")

if not exists then
  return
end

vim.notify = notify
