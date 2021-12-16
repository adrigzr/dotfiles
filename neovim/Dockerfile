FROM alpine:edge

# Labels
LABEL maintainer="Adrián González Rus <adrigzr@users.noreply.github.com>"

# Install packages
RUN apk update && \
  apk add --no-cache \
  build-base \
  cargo \
  curl \
  editorconfig \
  fd \
  fzf \
  git \
  gzip \
  ncurses ncurses-dev ncurses-libs ncurses-terminfo \
  neovim \
  neovim-doc \
  nodejs \
  npm \
  openssl-dev \
  python3 python3-dev \
  ripgrep \
  stow \
  wget \
  && \
  rm -rf /var/cache/apk/*

# Node deps
RUN npm install -g neovim yarn

# Python deps
RUN ln -sf /usr/bin/python3 /usr/bin/python && \
  python -m ensurepip && \
  pip3 install --no-cache --upgrade pip neovim

# Download dotfiles
RUN git clone --no-checkout --depth 1 --branch feature-neovim https://github.com/adrigzr/dotfiles.git ~/dotfiles && \
  cd ~/dotfiles && \
  git sparse-checkout init --cone && \
  git sparse-checkout set neovim && \
  git checkout && \
  stow neovim

# Install packer
RUN git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Setup neovim
RUN nvim --headless -c "autocmd User PackerComplete quitall" -c "PackerSync"

# Setup workdir
WORKDIR /code

# Setup environment
ENV TERM=xterm-256color

# Setup entrypoint
ENTRYPOINT ["nvim"]
