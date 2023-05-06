local exists, neotest = pcall(require, "neotest")

if not exists then
  return
end

-- require("neotest-jest").getStrategyConfig = function(strategy, args)
--   vim.pretty_print(strategy, args)
--   return strategy
-- end

local is_test_file = require("neotest-mocha.util").create_test_file_extensions_matcher({ "test" }, { "ts" })

neotest.setup {
  adapters = {
    require "neotest-mocha" {
      is_test_file = is_test_file,
      -- },
      -- require "neotest-jest" {
      -- strategy_config = function(strategy)
      --   strategy.type = "node2"

      --   vim.pretty_print(strategy)

      --   return {
      --     name = "Debug Jest Tests",
      --     type = "node2",
      --     args = strategy.args,
      --     console = "integratedTerminal",
      --     cwd = "${workspaceFolder}",
      --     internalConsoleOptions = "neverOpen",
      --     request = "launch",
      --     rootPath = "${workspaceFolder}",
      --     runtimeExecutable = strategy.runtimeExecutable,
      --   }
      -- end,
    },
    require "neotest-rspec" {},
    require "neotest-python" {},
    require "neotest-rust" {},
    require "neotest-plenary" {},
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
  quickfix = {
    open = false,
  },
}

local bind = require("custom.util.misc").bind
local map = vim.keymap.set

local function runFile()
  neotest.run.run { vim.fn.expand "%" }
end

map("n", "<leader>uu", neotest.run.run, { desc = "Run the nearest test" })
map("n", "<leader>ue", bind(neotest.run.run, { { suite = true } }), { desc = "Run the nearest test" })
map("n", "<leader>ul", neotest.run.run_last, { desc = "Run the last test" })
map("n", "<leader>ut", neotest.run.stop, { desc = "Stop the test" })
map("n", "<leader>ua", neotest.run.attach, { desc = "Attach to the nearest test" })
map("n", "<leader>ud", bind(neotest.run.run, { { strategy = "dap" } }), { desc = "Debug the nearest test" })
map("n", "<leader>uf", runFile, { desc = "Run the tests on the current file" })
map("n", "<leader>us", neotest.summary.toggle, { desc = "Toggle the test summary" })
map("n", "<leader>uo", bind(neotest.output.open, { { short = true } }), { desc = "Open the test output" })
map("n", "<leader>un", bind(neotest.jump.next, { { status = "failed" } }), { desc = "Jump to the next failed test" })
map(
  "n",
  "<leader>up",
  bind(neotest.jump.prev, { { status = "failed" } }),
  { desc = "Jump to the previous failed test" }
)
