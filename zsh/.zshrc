# uncomment to profile prompt startup with zprof
# zmodload zsh/zprof

# history
SAVEHIST=100000

# Custom functions.
fpath=( "$HOME/.zfunctions" "$HOME/.ripgrep/complete" "/usr/local/share/doc/task/scripts/zsh" $fpath )

# Termite support.
# Tell Termite what the current directory is.
if [[ $TERM == xterm-termite ]]; then
  source /etc/profile.d/vte.sh
  __vte_osc7
  export TERM='xterm-256color'
fi

# Config autosuggestions.
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=59"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=true

# zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# Load default dotfiles
[ -s ~/.profile  ] && source ~/.profile

# Setup fzf (fuzzy-finder).
[ -s ~/.fzf.zsh ] && source ~/.fzf.zsh

# Fix git aliases
zstyle ':zim:git' aliases-prefix 'g'

# Source zim.
# Update static initialization script if it's outdated, before sourcing it
if [[ ${ZIM_HOME}/init.zsh -ot ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi

source ${ZIM_HOME}/init.zsh

# Alias tips.
[ -s ~/.zsh/alias-tips/alias-tips.plugin.zsh ] && source ~/.zsh/alias-tips/alias-tips.plugin.zsh

# Fast Syntax Highlighting
[ -s ~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ] && source ~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# Quiet accept line.
[ -s ~/.zsh/zsh-quiet-accept-line/quiet-accept-line.zsh ] && source ~/.zsh/zsh-quiet-accept-line/quiet-accept-line.zsh

# PM2
[ -s ~/.zsh/pm2.zsh ] && source ~/.zsh/pm2.zsh

# Vi mode.
function zle-keymap-select { zle reset-prompt ; zle -R }
zle -N zle-keymap-select
# bindkey -v
bindkey -e
export KEYTIMEOUT=1

# Edit command line on vim.
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd '^e' edit-command-line
bindkey '^x^e' edit-command-line

# bind UP and DOWN arrow keys for history search plugin
zmodload zsh/terminfo
bindkey "$terminfo[khome]" beginning-of-line # Home
bindkey "$terminfo[kend]" end-of-line # End
bindkey "$terminfo[kdch1]" delete-char # Delete
bindkey "$terminfo[kich1]" overwrite-mode # Insert
bindkey "$terminfo[kbs]" backward-delete-char # Backspace
bindkey "$terminfo[kpp]" beginning-of-buffer-or-history # PageUp
bindkey "$terminfo[knp]" end-of-buffer-or-history # PageDown
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Autoload functions.
autoload -U vim
autoload -U zle-select-branch; zle -N zle-select-branch; bindkey '^B' zle-select-branch
autoload -U zle-select-tag; zle -N zle-select-tag; bindkey '^G' zle-select-tag

# Custom bindings.
bindkey -s '^P' "fvim\n"

# History backwards
bindkey '^r' history-incremental-search-backward

# Bind autosuggestions.
bindkey '^A' autosuggest-accept

# Fix "cd .." autocompletion.
zstyle ':completion:*' special-dirs true

# history mgmt
# http://www.refining-linux.org/archives/49/ZSH-Gem-15-Shared-history/
setopt inc_append_history
setopt share_history

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

# Prompt for spelling correction of commands.
setopt CORRECT

# uncomment to finish profiling
# zprof
