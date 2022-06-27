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

local function setConditionalBreakpoint()
  dap.set_breakpoint(vim.fn.input "Breakpoint condition: ")
end

local function setLogPoint()
  dap.set_breakpoint(nil, nil, vim.fn.input "Log point message: ")
end

require("which-key").register({
  name = "DAP",
  c = { dap.continue, "Continue the debugger" },
  o = { dap.step_over, "Step over the current line" },
  i = { dap.step_into, "Step into the current line" },
  O = { dap.step_out, "Step out the current line" },
  b = { dap.toggle_breakpoint, "Toggle breakpoint" },
  B = { setConditionalBreakpoint, "Set conditional breakpoint" },
  l = { setLogPoint, "Set log point" },
}, { prefix = "<leader>d" })
