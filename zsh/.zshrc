# uncomment to profile prompt startup with zprof
# zmodload zsh/zprof

# History.
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# Deduplicate PATH and fpath entries.
typeset -U path fpath

# Custom functions.
fpath=( "$HOME/.zfunctions" $fpath )

# Config autosuggestions.
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=59"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# Load default dotfiles
[ -s "$HOME/.profile"  ] && source "$HOME/.profile"

# Fix git aliases
zstyle ':zim:git' aliases-prefix 'g'

# Source zim.
ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
    https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# Install missing modules and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi

# Initialize modules.
source ${ZIM_HOME}/init.zsh

# Modern ls (eza) — must be after zim utility module to override its ls alias.
if (( $+commands[eza] )); then
  alias ls='eza --icons'
  alias la='eza --icons -la'
  alias ll='eza --icons -l'
  alias tree='eza --icons --tree'
fi

# Cache and source a tool's init output (regenerates when binary changes).
_cached_eval() {
  local cmd=$1; shift
  local cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
  local cache_file="$cache_dir/$cmd.zsh"
  local bin_path="${commands[$cmd]}"
  if [[ ! -f "$cache_file" || "$bin_path" -nt "$cache_file" ]]; then
    mkdir -p "$cache_dir"
    "$cmd" "$@" > "$cache_file"
  fi
  source "$cache_file"
}

# Starship prompt.
(( $+commands[starship] )) && _cached_eval starship init zsh

# Zoxide (smart cd).
(( $+commands[zoxide] )) && _cached_eval zoxide init zsh

# fnm (fast node manager).
(( $+commands[fnm] )) && _cached_eval fnm env --use-on-cd

# Setup fzf (fuzzy-finder).
(( $+commands[fzf] )) && _cached_eval fzf --zsh

# Vi mode.
function zle-keymap-select { zle reset-prompt ; zle -R }
zle -N zle-keymap-select
bindkey -v
KEYTIMEOUT=1

# Edit command line on vim.
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd '^e' edit-command-line
bindkey '^x^e' edit-command-line

# Keybindings (terminfo-based, guarded against missing keys).
zmodload zsh/terminfo
[[ -n "$terminfo[khome]" ]] && bindkey "$terminfo[khome]" beginning-of-line
[[ -n "$terminfo[kend]"  ]] && bindkey "$terminfo[kend]"  end-of-line
[[ -n "$terminfo[kdch1]" ]] && bindkey "$terminfo[kdch1]" delete-char
[[ -n "$terminfo[kich1]" ]] && bindkey "$terminfo[kich1]" overwrite-mode
[[ -n "$terminfo[kbs]"   ]] && bindkey "$terminfo[kbs]"   backward-delete-char
[[ -n "$terminfo[kpp]"   ]] && bindkey "$terminfo[kpp]"   beginning-of-buffer-or-history
[[ -n "$terminfo[knp]"   ]] && bindkey "$terminfo[knp]"   end-of-buffer-or-history
[[ -n "$terminfo[kcuu1]" ]] && bindkey "$terminfo[kcuu1]" history-substring-search-up
[[ -n "$terminfo[kcud1]" ]] && bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Autoload functions.
autoload -U zle-select-branch; zle -N zle-select-branch; bindkey '^B' zle-select-branch
autoload -U zle-select-tag; zle -N zle-select-tag; bindkey '^G' zle-select-tag
autoload -U zle-fvim; zle -N zle-fvim; bindkey '^P' zle-fvim
autoload -U zle-history-search; zle -N zle-history-search; bindkey '^R' zle-history-search
autoload -U zle-select-directory; zle -N zle-select-directory; bindkey '^F' zle-select-directory

# Bind autosuggestions.
bindkey '^A' autosuggest-accept

# Fix "cd .." autocompletion.
zstyle ':completion:*' special-dirs true

# history mgmt
# http://www.refining-linux.org/archives/49/ZSH-Gem-15-Shared-history/
setopt share_history

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

# Prompt for spelling correction of commands.
# setopt CORRECT

# uncomment to finish profiling
# zprof
