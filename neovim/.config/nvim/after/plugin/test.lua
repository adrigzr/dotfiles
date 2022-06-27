local exists, neotest = pcall(require, "neotest")

if not exists then
  return
end

neotest.setup {
  adapters = {
    require "neotest-jest" {},
    require "neotest-rspec" {},
    require "neotest-python" {},
    -- require "neotest-vim-test" { ignore_filetypes = { "ruby", "python" } },
  },
  icons = {
    failed = "",
    passed = "",
    running = "",
    skipped = "",
    unknown = "",
  },
  output = {
    open_on_run = false,
  },
}

local misc = require "custom.util.misc"

local function runFile()
  neotest.run.run { vim.fn.expand "%" }
end

require("which-key").register({
  name = "Neotest",
  u = { neotest.run.run, "Run the nearest test" },
  l = { neotest.run.run_last, "Run the last test" },
  t = { neotest.run.stop, "Stop the test" },
  a = { neotest.run.attach, "Attach to the nearest test" },
  d = { misc.bind(neotest.run.run, { { strategy = "dap" } }), "Debug the nearest test" },
  f = { runFile, "Run the tests on the current file" },
  s = { neotest.summary.toggle, "Toggle the test summary" },
  o = { misc.bind(neotest.output.open, { { short = true } }), "Open the test output" },
  p = { misc.bind(neotest.jump.prev, { { status = "failed" } }), "Jump to the previous failed test" },
  n = { misc.bind(neotest.jump.next, { { status = "failed" } }), "Jump to the next failed test" },
}, { prefix = "<leader>u" })
