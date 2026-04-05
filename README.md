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
   brew install lazygit gh ast-grep imagemagick pngpaste
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
   git clone --recurse-submodules https://github.com/adrigzr/dotfiles.git ~/dotfiles && cd $_
    stow git neovim ssh system tmux zsh ghostty ruby claude
   ```

1. Install fonts (restart may be required).

   ```bash
   brew install --cask font-lilex-nerd-font
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
   # Setup tpm
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

### Debian

1. Update system and install essential build tools.

   ```bash
   sudo apt update && sudo apt upgrade -y
   sudo apt install -y build-essential curl wget git unzip cmake gettext
   ```

1. Install useful packages.

   ```bash
   sudo apt install -y ripgrep fzf stow editorconfig bat gpg gawk htop ffmpeg jq fd-find moreutils
   sudo apt install -y python3-pip python3-venv
   ```

   > **Note:** On Debian, `fd` is installed as `fdfind` and `bat` as `batcat`. Create symlinks:
   >
   > ```bash
   > sudo ln -sf $(which fdfind) /usr/local/bin/fd
   > sudo ln -sf $(which batcat) /usr/local/bin/bat
   > ```

1. Install tools not available in apt repositories.

   ```bash
   # starship
   curl -sS https://starship.rs/install.sh | sh

   # fnm
   curl -fsSL https://fnm.vercel.app/install | bash

   # zoxide
   curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

   # eza
   sudo mkdir -p /etc/apt/keyrings
   wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
   echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
   sudo apt update && sudo apt install -y eza

   # git-delta
   cargo install git-delta  # requires rustup: https://rustup.rs

   # lazygit
   LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
   curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
   tar xf lazygit.tar.gz lazygit && sudo install lazygit /usr/local/bin && rm lazygit lazygit.tar.gz

   # gh (GitHub CLI)
   (type -p wget >/dev/null || sudo apt install wget) \
     && sudo mkdir -p -m 755 /etc/apt/keyrings \
     && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
     && cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
     && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
     && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
     && sudo apt update && sudo apt install gh -y

   # ast-grep
   cargo install ast-grep  # requires rustup

   # stylua
   cargo install stylua

   # selene
   cargo install selene
   ```

1. Install Neovim (latest stable from source or AppImage).

   ```bash
   curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
   chmod u+x nvim-linux-x86_64.appimage
   sudo mv nvim-linux-x86_64.appimage /usr/local/bin/nvim
   ```

1. Install tmux.

   ```bash
   sudo apt install -y tmux
   ```

1. Install latest LTS Node via [fnm](https://github.com/Schniz/fnm) (installed above).

   ```bash
   fnm install --lts
   npm install -g prettier
   ```

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
   git clone --recurse-submodules https://github.com/adrigzr/dotfiles.git ~/dotfiles && cd $_
   stow git neovim ssh system tmux zsh ruby
   ```

1. Install fonts.

   ```bash
   mkdir -p ~/.local/share/fonts
   curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Lilex.zip
   unzip Lilex.zip -d ~/.local/share/fonts/Lilex && rm Lilex.zip
   fc-cache -fv
   ```

1. Setup zsh & [zim](https://github.com/zimfw/zimfw).

   ```bash
   sudo apt install -y zsh
   chsh -s $(which zsh)
   ```

   zimfw is auto-downloaded on first shell start. Open a new zsh session, then:

   ```bash
   zimfw install
   ```

1. Setup tmux & [tpm](https://github.com/tmux-plugins/tpm).

   ```bash
   tic -x tmux/screen-256color.terminfo
   infocmp -x $TERM
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
   ~/.tmux/plugins/tpm/bin/install_plugins
   ```

1. Install a terminal emulator ([Ghostty](https://ghostty.org) or your preferred choice) and open it.

1. Setup neovim.

   ```text
   :Lazy sync
   :checkhealth
   ```

## Packages

| Package   | Description                                          |
|-----------|------------------------------------------------------|
| `bash`    | Bash shell config                                    |
| `claude`  | Claude Code settings and global instructions         |
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
| `ripgrep` | grug-far, Snacks.picker | Live grep and search |
| `fd` | Snacks.picker, Snacks.explorer | File finder |
| `git` | diffview, gitsigns, Snacks.picker | VCS integration |
| `node` | copilot.lua, nvim-treesitter | Copilot LSP, parser builds |
| `lazygit` | Snacks.lazygit | Terminal UI for git |
| `ast-grep` | grug-far | Structural code search |
| `imagemagick` | Snacks.image | Image conversion and display |
| `pngpaste` | obsidian.nvim | Paste images from clipboard into notes |
| `stylua` | CI, conform.nvim | Lua code formatter |
| `selene` | CI | Lua linter |
