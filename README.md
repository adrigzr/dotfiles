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
    brew tap homebrew/cask-fonts
    brew install git tmux ripgrep fzf stow gnu-sed neovim editorconfig bat asdf gpg gawk htop ffmpeg jq fd
    brew install --cask iterm2 font-hack-nerd-font
    ```

1. Clone repository and stow packages.

    ```bash
    git clone --recurse-submodules -j8 https://github.com/adrigzr/dotfiles.git ~/dotfiles && cd $_
    stow asdf git neovim ssh system tmux vim zsh
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

1. Setup zsh & [zim](https://github.com/zimfw/zimfw)

    ```bash
    curl -s -L --create-dirs -o ~/.zim/zimfw.zsh https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
    zsh ~/.zim/zimfw.zsh install
    ```

1. Setup tmux & [tpm](https://github.com/tmux-plugins/tpm)

    ```bash
    tic tmux/screen-256color.terminfo
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    ~/.tmux/plugins/tpm/bin/install_plugins
    ```

1. Setup [asdf](https://github.com/asdf-vm/asdf)

    ```bash
    asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
    asdf install
    ```

1. Setup node

    ```bash
    npm install -g bash-language-server
    ```

1. Setup neovim

    ```bash
    nvim -c "PlugUpgrade" -c "PlugInstall" -c "checkhealth"
    ```
