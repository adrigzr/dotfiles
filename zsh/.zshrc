# uncomment to profile prompt startup with zprof
# zmodload zsh/zprof

# history
SAVEHIST=100000

# Custom functions.
fpath=( "$HOME/.zfunctions" "$HOME/.ripgrep/complete" $fpath )

# Termite support.
# Tell Termite what the current directory is.
if [[ $TERM == xterm-termite ]]; then
  source /etc/profile.d/vte.sh
  __vte_osc7
  export TERM='xterm-256color'
fi

# Load default dotfiles
[ -s ~/.profile  ] && source ~/.profile

# Setup fzf (fuzzy-finder).
[ -s ~/.fzf.zsh ] && source ~/.fzf.zsh

# Source zim.
[ -s ${ZDOTDIR:-${HOME}}/.zim/init.zsh ] && source ${ZDOTDIR:-${HOME}}/.zim/init.zsh

# Alias tips.
[ -s ~/.zsh/alias-tips/alias-tips.plugin.zsh ] && source ~/.zsh/alias-tips/alias-tips.plugin.zsh

# Autoload functions.
autoload -U vim
autoload -U zle-select-branch; zle -N zle-select-branch; bindkey "^B" zle-select-branch
autoload -U zle-select-tag; zle -N zle-select-tag; bindkey "^G" zle-select-tag

# Custom bindings.
bindkey -s "^P" "fvim\n"

# Vi mode.
bindkey -v
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# bind UP and DOWN arrow keys for history search plugin
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Fix ctrl+arrow keys.
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Config to make suggestion highlight visible.
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=11"

# history mgmt
# http://www.refining-linux.org/archives/49/ZSH-Gem-15-Shared-history/
setopt inc_append_history
setopt share_history

# Powerline.
[ -f $PYTHON3_PACKAGES/powerline/bindings/zsh/powerline.zsh ] && source $PYTHON3_PACKAGES/powerline/bindings/zsh/powerline.zsh

# uncomment to finish profiling
# zprof

