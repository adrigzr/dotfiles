local codecompanion = require "codecompanion"

-- Required for live buffer reloading when tools edit files
vim.o.autoread = true

codecompanion.setup {
  interactions = {
    chat = {
      adapter = {
        name = "anthropic",
        model = "claude-opus-4-6",
      },
      opts = {
        completion_provider = "blink",
      },
      variables = {
        ["buffer"] = {
          opts = { default_params = "diff" },
        },
      },
      tools = {
        opts = {
          auto_submit_errors = true,
          auto_submit_success = true,
          default_tools = { "full_stack_dev" },
        },
      },
    },
    inline = {
      adapter = {
        name = "anthropic",
        model = "claude-sonnet-4-5",
      },
      keymaps = {
        accept_change = { modes = { n = "gda" } },
        reject_change = { modes = { n = "gdr" } },
      },
    },
    cmd = {
      adapter = {
        name = "anthropic",
        model = "claude-sonnet-4-5",
      },
    },
    background = {
      adapter = {
        name = "anthropic",
        model = "claude-sonnet-4-5",
      },
    },
  },
  display = {
    action_palette = {
      provider = "snacks",
    },
    chat = {
      show_token_count = true,
      fold_context = true,
      window = {
        layout = "vertical",
      },
    },
    diff = {
      enabled = true,
      provider = "inline",
      provider_opts = {
        inline = {
          layout = "float",
        },
      },
    },
  },
}

require("custom.code_actions").setup()
