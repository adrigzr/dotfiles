local exists, opencode = pcall(require, "opencode")

if not exists then
  return
end

---@type opencode.Opts
vim.g.opencode_opts = {
  provider = {
    enabled = "snacks",
  },
}

local map = vim.keymap.set

-- Ask opencode with @this context
map({ "n", "x" }, "<leader>oa", function()
  opencode.ask("@this: ", { submit = true })
end, { desc = "Ask opencode" })

-- Select from opencode actions
map({ "n", "x" }, "<leader>os", function()
  opencode.select()
end, { desc = "Select opencode action" })

-- Toggle opencode terminal
map("n", "<leader>ot", function()
  opencode.toggle()
end, { desc = "Toggle opencode" })

-- Operator: add range to opencode (supports dot-repeat)
map({ "n", "x" }, "go", function()
  return opencode.operator "@this "
end, { desc = "Add range to opencode", expr = true })

-- Operator: add current line to opencode
map("n", "goo", function()
  return opencode.operator "@this " .. "_"
end, { desc = "Add line to opencode", expr = true })
