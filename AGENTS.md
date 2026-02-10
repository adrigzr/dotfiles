# AGENTS.md

Personal dotfiles repository managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level directory is a stow package that mirrors `$HOME`. The heaviest component is the Neovim configuration (~70 Lua files under `neovim/.config/nvim/`, 100% Lua -- no VimScript).

## Repository Structure

```
bash/        - Bash shell config
eslint/      - Global ESLint config
fonts/       - Nerd Font patched fonts
git/         - Git config, custom git subcommands (git/bin/)
i3/          - i3 window manager config + scripts (Linux)
iterm2/      - iTerm2 terminfo overrides
neovim/      - Full Neovim config (Lua, lazy.nvim)
ruby/        - Ruby config
ssh/         - SSH client config
system/      - Shared shell config (.profile, .exports, .aliases, .functions)
tmux/        - tmux config with TPM plugins
zsh/         - Zsh config with Zim framework
```

## Build / Lint / Test Commands

There is no build system (no Makefile, package.json, or justfile). CI runs a single StyLua check.

### Lua Formatting (StyLua)

```bash
# Check all Neovim Lua files (what CI runs)
stylua --check neovim/.config

# Format in-place
stylua neovim/.config

# Check a single file
stylua --check neovim/.config/nvim/lua/custom/plugins.lua
```

Config: `stylua.toml` -- spaces, 2-width indent, no call parentheses.

### Lua Linting (Selene)

```bash
selene neovim/.config/nvim/lua/
selene neovim/.config/nvim/lua/custom/settings.lua   # single file
```

Config: `selene.toml` (std=vim) + `vim.toml` (lua51 base, vim globals).

### Deploying Changes

```bash
stow <package>           # Symlink a package to $HOME
stow -R <package>        # Re-stow (update symlinks)
stow -D <package>        # Remove symlinks
# Example: stow -R neovim git zsh system
```

## Code Style -- Lua (Neovim Config)

### Formatting

- **2-space indentation**, spaces only (enforced by stylua.toml + .editorconfig)
- **LF line endings**, trailing whitespace trimmed, final newline required
- **Double quotes** for all strings: `require "custom.settings"`, `vim.g.mapleader = " "`
- **`[[...]]`** double-bracket strings for multiline content (e.g., highlight commands)

### Require / Import Style

```lua
-- Bare require (no parens) for simple imports
require "custom.settings"
local async = require "plenary.async"

-- Parenthesized require only when chaining .setup()
require("lazy").setup({ ... })
require("typescript-tools").setup { ... }
```

### Module Pattern

Every module in `lua/custom/` uses:

```lua
local M = {}

local function private_helper()  -- private: local function
  ...
end

function M.public_method()       -- public: on M table
  ...
end

return M
```

Plugin configuration lives in `after/plugin/*.lua` (side-effect files, no return).

LSP server configurations live in `lsp/*.lua` (Neovim 0.11+ `vim.lsp.config` style, one file per server).

Early-load settings live in `plugin/*.lua` (vim.g variables, autocmds, user commands).

### Error Handling

Every `after/plugin/` file starts with a pcall guard:

```lua
local exists, telescope = pcall(require, "telescope")
if not exists then return end
```

Use `pcall` for all fallible requires and API calls. No `error()` or `assert()`.

### Naming Conventions

- **`snake_case`** for functions, variables, parameters: `common_on_attach`, `file_ignore_patterns`
- **`M`** for the module table (always)
- **`SCREAMING_CASE`** only for debug globals in `globals.lua` (`P`, `RELOAD`, `R`)
- **`local`** everything -- no globals except the three debug helpers
- **`vim.g.*`** for Vim global options: `vim.g.mapleader = " "`

### Comments

Prefer minimal comments. Comment *why*, not *what*. Use `-- Single line` with space after dashes, `-- [PluginName]` section markers for highlight groups, and `--- @param` LuaDoc annotations (rare, only for public API).

### Plugin Specs (lazy.nvim)

```lua
"nvim-lua/plenary.nvim",                                                     -- string-only
{ "tpope/vim-markdown", ft = "markdown" },                                   -- lazy by ft
{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },                  -- with build
{ "navarasu/onedark.nvim", lazy = false, config = function() require "custom.theme" end },
```

Setup calls go in `after/plugin/`, not in the lazy spec.

### Keymaps

Always use `vim.keymap.set` with a `desc`: `map("n", "<leader>vi", "<cmd>LspInstallInfo<cr>", { desc = "Show lsp install info" })`

General keymaps live in `plugin/mappings.lua`. Plugin-specific keymaps live in the corresponding `after/plugin/*.lua` file.

## Code Style -- Shell Scripts

- **2-space indentation** (matches .editorconfig); shebang `#!/usr/bin/env bash` for originals
- End files with `# vim: ft=sh` or `# vim: ft=zsh` modeline when filetype is ambiguous
- Interactive functions (`.functions`): `function name() { ... }` with explicit keyword
- Standalone scripts: POSIX-style `name() { ... }` without keyword
- **`local`** + `lowercase_snake_case` for function-scoped: `local port="${1:-9000}"`
- **`UPPER_SNAKE_CASE`** for exports: `export XDG_CONFIG_HOME="$HOME/.config"`
- **Double-quote** variables: `"$HOME"`, `"$1"`, `"$file"`; use `${var:-default}` for defaults
- Source guard: `[ -s "$HOME/.profile" ] && source "$HOME/.profile"`
- Aliases organized by category in `system/.aliases`; single-letter shortcuts: `g`=git, `v`=nvim

## Code Style -- Git Configuration

- Short abbreviations for common commands: `co`, `st`, `ci`, `br`
- Complex aliases use `"!f() { ...; }; f"` inline shell function pattern
- Custom subcommands as `git-<name>` executables in `git/bin/`
- Machine-specific overrides via `include.path = ~/.gitconfig.extra`

## Editor / Tooling Config Summary

| Tool       | Config File                          | Purpose                                    |
|------------|--------------------------------------|--------------------------------------------|
| StyLua     | `stylua.toml`                        | Lua formatter (spaces, 2-width, no parens) |
| Selene     | `selene.toml` + `vim.toml`           | Lua linter (vim std, lua51 base)           |
| ESLint     | `eslint/.eslintrc`                   | JS linter (ES6, single quotes, 2-space)    |
| EditorConfig| `.editorconfig`                     | Universal: LF, 2-space, trim whitespace    |
| Lua LSP    | `neovim/.config/nvim/.luarc.json`    | Disable third-party workspace checking     |

## CI

GitHub Actions (`.github/workflows/ci.yml`): runs `stylua --check neovim/.config` on push and PR. This is the only automated check -- ensure Lua files pass before committing.
