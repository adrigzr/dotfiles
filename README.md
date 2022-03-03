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
   brew tap homebrew/cask-versions
   brew install git wget ripgrep fzf stow gnu-sed editorconfig bat asdf gpg gawk htop ffmpeg jq fd moreutils git-delta
   brew install iterm2-beta
   brew install tmux --HEAD
   brew install neovim --HEAD
   ```

1. Install [nvm](https://github.com/nvm-sh/nvm)

   ```bash
   nvm install --lts
   nvm alias default "$(nvm version-remote --lts)"
   npm install -g neovim yarn prettier bash-language-server
   ```

1. Install [rust](https://www.rust-lang.org/tools/install)

   ```bash
   cargo install stylua
   cargo install selene
   ```

1. Install [Docker Desktop](https://www.docker.com/products/docker-desktop)

1. Setup python packages

   ```bash
   pip3 install --upgrade pip
   pip3 install neovim vim-vint
   ```

1. Setup [asdf](https://github.com/asdf-vm/asdf)

   ```bash
   asdf plugin-add java https://github.com/halcyon/asdf-java.git
   asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
   asdf install
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
   stow asdf git neovim ssh system tmux zsh
   ```

1. Copy fonts (restart may be required)

   ```bash
   cp -r fonts/* ~/Library/Fonts
   ```

1. Setup zsh & [zim](https://github.com/zimfw/zimfw)

   ```bash
   curl -s -L --create-dirs -o ~/.zim/zimfw.zsh https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
   zsh ~/.zim/zimfw.zsh install
   ```

1. Setup tmux & [tpm](https://github.com/tmux-plugins/tpm)

   ```bash
   tic -x iterm2/xterm-256color.terminfo
   tic -x tmux/screen-256color.terminfo
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
   ~/.tmux/plugins/tpm/bin/install_plugins
   ```

1. Tweak Mac OS default settings

   Reduce key repeat delay:

   ```bash
   defaults write -g InitialKeyRepeat -int 10
   defaults write -g KeyRepeat -int 1
   ```

   Increase duration of notifications:

   ```bash
   defaults write com.apple.notificationcenterui bannerTime -int 1
   ```

1. Open iterm2 and setup profile

1. Setup neovim

   ```text
   PackerSync
   LspInstall pyright graphql dotls dockerls tsserver html bashls jsonls vimls rust_analyzer yamlls eslint sumneko_lua cssls
   checkhealth
   ```
