local exists, dap = pcall(require, "dap")

if not exists then
  return
end

vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "⊜", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "✦", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "→", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "⊗", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

require("nvim-dap-virtual-text").setup {}

local dapui = require "dapui"

dapui.setup {
  floating = {
    border = "rounded",
  },
}

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open(nil)
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close(nil)
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close(nil)
end

dap.adapters.node2 = {
  type = "executable",
  command = "node",
  args = { os.getenv "HOME" .. "/Repositories/vscode-node-debug2/out/src/nodeDebug.js" },
}

dap.configurations.javascript = {
  {
    name = "Launch",
    type = "node2",
    request = "launch",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
  },
  {
    -- For this to work you need to make sure the node process is started with the `--inspect` flag.
    name = "Attach to process",
    type = "node2",
    request = "attach",
    processId = require("custom.util.misc").pick_process,
  },
}

dap.configurations.typescript = dap.configurations.javascript

vim.keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<CR>")
vim.keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_over()<CR>")
vim.keymap.set("n", "<leader>di", "<cmd>lua require'dap'.step_into()<CR>")
vim.keymap.set("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<CR>")
vim.keymap.set("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set("n", "<leader>dB", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
vim.keymap.set(
  "n",
  "<leader>dl",
  "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>"
)
