# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Installation

### Mac OS

1. Upgrade to latest Mac OS version and install CLT.

   ```bash
   softwareupdate --all --install --force
   sudo xcode-select --install
   ```

1. Install [brew](https://brew.sh) and useful packages.

   ```bash
   brew install git wget ripgrep fzf stow gnu-sed editorconfig bat gpg gawk htop ffmpeg jq fd moreutils git-delta
   brew install starship fnm zoxide eza
   brew install stylua selene
   brew install lazygit gh ast-grep imagemagick
   brew install --cask ghostty
   brew install tmux
   brew install neovim
   ```

1. Install latest LTS Node via [fnm](https://github.com/Schniz/fnm) (installed above).

   ```bash
   fnm install --lts
   npm install -g prettier
   ```

1. Install [Docker Desktop](https://www.docker.com/products/docker-desktop)

1. Setup python packages.

   ```bash
   pip3 install --upgrade pip
   pip3 install pynvim
   ```

1. Create default files and directories to prevent stow from colliding.

   ```bash
   mkdir -p ~/.config ~/.ssh/control
   ```

1. Clone repository and stow packages.

   ```bash
   git clone --recurse-submodules -j8 https://github.com/adrigzr/dotfiles.git ~/dotfiles && cd $_
   stow git neovim ssh system tmux zsh ghostty ruby
   ```

1. Install fonts (restart may be required).

   ```bash
   # Ligalex Mono (custom ligature patch, bundled in fonts/)
   cp -r fonts/* ~/Library/Fonts
   # Optional: IBM Plex Mono Nerd Font (available via Homebrew)
   brew install --cask font-blex-mono-nerd-font
   ```

1. Setup zsh & [zim](https://github.com/zimfw/zimfw).

   zimfw is auto-downloaded on first shell start. Just open a new zsh session, then:

   ```bash
   zimfw install
   ```

1. Setup tmux & [tpm](https://github.com/tmux-plugins/tpm).

   ```bash
   tic -x tmux/screen-256color.terminfo
   # Restart tmux & Ghostty and check infos
   infocmp -x $TERM
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
   ~/.tmux/plugins/tpm/bin/install_plugins
   ```

1. Tweak Mac OS default settings.

   Reduce key repeat delay:

   ```bash
   defaults write -g InitialKeyRepeat -int 10
   defaults write -g KeyRepeat -int 1
   defaults write -g ApplePressAndHoldEnabled -bool false
   ```

   Increase duration of notifications:

   ```bash
   defaults write com.apple.notificationcenterui bannerTime -int 1
   ```

1. Open Ghostty (config is already stowed).

1. Setup neovim.

   ```text
   :Lazy sync
   :checkhealth
   ```

## Packages

| Package   | Description                                          |
|-----------|------------------------------------------------------|
| `bash`    | Bash shell config                                    |
| `fonts`   | Ligalex Mono Nerd Font (patched)                     |
| `ghostty` | Ghostty terminal config                              |
| `git`     | Git config, custom git subcommands (`git/bin/`)      |
| `neovim`  | Full Neovim config (Lua, lazy.nvim)                  |
| `ruby`    | Ruby config                                          |
| `ssh`     | SSH client config                                    |
| `system`  | Shared shell config (`.profile`, `.exports`, `.aliases`, `.functions`) |
| `tmux`    | tmux config with TPM plugins                         |
| `zsh`     | Zsh config with Zim framework                        |

## Shell Tools

- **[starship](https://starship.rs)** -- Cross-shell prompt
- **[zoxide](https://github.com/ajeetdsouza/zoxide)** -- Smart `cd` replacement
- **[fnm](https://github.com/Schniz/fnm)** -- Fast Node version manager
- **[fzf](https://github.com/junegunn/fzf)** -- Fuzzy finder
- **[ripgrep](https://github.com/BurntSushi/ripgrep)** -- Fast grep
- **[fd](https://github.com/sharkdp/fd)** -- Fast find
- **[bat](https://github.com/sharkdp/bat)** -- cat with syntax highlighting, MANPAGER
- **[eza](https://github.com/eza-community/eza)** -- Modern ls replacement with icons and git integration
- **[delta](https://github.com/dandavella/delta)** -- Git diff pager

## Neovim Dependencies

External tools required by Neovim plugins. All installed via `brew install`.

| Package | Required by | Purpose |
|---------|-------------|---------|
| `ripgrep` | telescope, grug-far, Snacks.picker | Live grep and search |
| `fd` | telescope, Snacks.picker | File finder |
| `git` | diffview, CopilotChat, telescope | VCS integration |
| `node` | copilot.lua, nvim-treesitter | Copilot LSP, parser builds |
| `lazygit` | Snacks.lazygit | Terminal UI for git |
| `gh` | CopilotChat | GitHub CLI for improved auth |
| `ast-grep` | grug-far | Structural code search |
| `imagemagick` | Snacks.image | Image conversion and display |
| `stylua` | CI, formatting | Lua code formatter |
| `selene` | linting | Lua linter |
