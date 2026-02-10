# dotfiles

## Installation

### Mac OS

1. Upgrade to latest Mac OS version and install CLT.

   ```bash
   softwareupdate --all --install --force
   sudo xcode-select --install
   ```

1. Install [brew](https://brew.sh/index_es) and useful packages.

   ```bash
   brew install git wget ripgrep fzf stow gnu-sed editorconfig bat gpg gawk htop ffmpeg jq fd moreutils git-delta
   brew install starship fnm zoxide
   brew install iterm2
   brew install tmux --HEAD
   brew install neovim --HEAD
   ```

1. Install [fnm](https://github.com/Schniz/fnm) (fast node manager)

   ```bash
   fnm install --lts
   npm install -g neovim yarn prettier bash-language-server
   ```

1. Install [Docker Desktop](https://www.docker.com/products/docker-desktop)

1. Setup python packages

   ```bash
   pip3 install --upgrade pip
   pip3 install neovim vim-vint
   ```

1. Setup ruby

   ```bash
   gem install --user neovim
   ```

1. Create default files and directories to prevent stow from colliding

   ```bash
   mkdir -p ~/.config ~/.ssh/control
   ```

1. Clone repository and stow packages.

   ```bash
   git clone --recurse-submodules -j8 https://github.com/adrigzr/dotfiles.git ~/dotfiles && cd $_
   stow git neovim ssh system tmux zsh
   ```

1. Copy fonts (restart may be required)

   ```bash
   cp -r fonts/* ~/Library/Fonts
   ```

1. Setup zsh & [zim](https://github.com/zimfw/zimfw)

   zimfw is auto-downloaded on first shell start. Just open a new zsh session, then:

   ```bash
   zimfw install
   ```

1. Setup tmux & [tpm](https://github.com/tmux-plugins/tpm)

   ```bash
   tic -x iterm2/xterm-256color.terminfo
   tic -x tmux/screen-256color.terminfo
   # Restart tmux & iterm and check infos
   infocmp -x $TERM
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
   ~/.tmux/plugins/tpm/bin/install_plugins
   ```

1. Tweak Mac OS default settings

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

1. Open iterm2 and setup profile

1. Setup neovim

   ```text
   Lazy sync
   checkhealth
   ```
