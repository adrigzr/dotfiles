# uncomment to profile prompt startup with zprof
# zmodload zsh/zprof

# history
SAVEHIST=100000

# Custom functions.
fpath=( "$HOME/.zfunctions" "$HOME/.ripgrep/complete" "/usr/local/share/doc/task/scripts/zsh" "$HOME/.zim/modules/fasd/functions" $fpath )

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

# Fast Syntax Highlighting
[ -s ~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ] && source ~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# Quiet accept line.
[ -s ~/.zsh/zsh-quiet-accept-line/quiet-accept-line.zsh ] && source ~/.zsh/zsh-quiet-accept-line/quiet-accept-line.zsh

# Spaceship prompt.
[ -s ~/.zsh/zsh-spaceship-prompt.zsh ] && source ~/.zsh/zsh-spaceship-prompt.zsh

# Autoload functions.
autoload -U vim
autoload -U zle-select-branch; zle -N zle-select-branch; bindkey "^B" zle-select-branch
autoload -U zle-select-tag; zle -N zle-select-tag; bindkey "^G" zle-select-tag

# Custom bindings.
bindkey -s "^P" "fvim\n"

# Vi mode.
# bindkey -v
# autoload edit-command-line; zle -N edit-command-line
# bindkey -M vicmd v edit-command-line

# bind UP and DOWN arrow keys for history search plugin
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Fix ctrl+arrow keys.
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Bind autosuggestions.
bindkey "^A" autosuggest-accept

# Config autosuggestions.
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=11"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=true

# history mgmt
# http://www.refining-linux.org/archives/49/ZSH-Gem-15-Shared-history/
setopt inc_append_history
setopt share_history

# Fix "cd .." autocompletion.
zstyle ':completion:*' special-dirs true

# uncomment to finish profiling
# zprof
