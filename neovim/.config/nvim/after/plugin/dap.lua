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
  dapui.open {}
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close {}
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close {}
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

local function setConditionalBreakpoint()
  dap.set_breakpoint(vim.fn.input "Breakpoint condition: ")
end

local function setLogPoint()
  dap.set_breakpoint(nil, nil, vim.fn.input "Log point message: ")
end

vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue the debugger" })
vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over the current line" })
vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into the current line" })
vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step out the current line" })
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>dB", setConditionalBreakpoint, { desc = "Set conditional breakpoint" })
vim.keymap.set("n", "<leader>dl", setLogPoint, { desc = "Set log point" })
