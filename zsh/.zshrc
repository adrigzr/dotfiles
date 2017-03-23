# uncomment to profile prompt startup with zprof
# zmodload zsh/zprof

# history
SAVEHIST=100000

# Custom functions.
fpath=( "$HOME/.zfunctions" $fpath )

# Termite support.
# Tell Termite what the current directory is.
if [[ $TERM == xterm-termite ]]; then
  source /etc/profile.d/vte.sh
  __vte_osc7
  export TERM='xterm-256color'
fi

# Load default dotfiles
[ -f ~/.profile  ] && source ~/.profile

# Setup fzf (fuzzy-finder).
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# antigen time!
source ~/Repositories/antigen/antigen.zsh

######################################################################
### install some antigen bundles

local b="antigen-bundle"

# Don't load the oh-my-zsh's library. Takes too long. No need.
antigen use oh-my-zsh

# Guess what to install when running an unknown command.
$b command-not-found

# Helper for extracting different types of archives.
$b extract

# Enable vi mode.
# $b vi-mode

# atom editor
#$b atom

# homebrew  - autocomplete on `brew install`
#$b brew
#$b brew-cask

# Tracks your most used directories, based on 'frecency'.
#$b robbyrussell/oh-my-zsh plugins/z

# nicoulaj's moar completion files for zsh -- not sure why disabled.
# $b zsh-users/zsh-completions src

# Syntax highlighting on the readline
$b zsh-users/zsh-syntax-highlighting

# history search fuzzy
$b zsh-users/zsh-history-substring-search ./zsh-history-substring-search.zsh

# suggestions
$b zsh-users/zsh-autosuggestions

# colors for all files!
$b trapd00r/zsh-syntax-highlighting-filetypes

# dont set a theme, because pure does it all
# $b mafredri/zsh-async
#$b sindresorhus/pure

# Sudo
$b sudo

# History
# aliases h, hs, hsi.
$b history

# Git
$b git

# Git extras
$b git-extras

# Jira
$b jira

# Tip alias
$b djui/alias-tips

# Enhance z.
$b changyuheng/fz

# Pastebin sprunge
# $b sprunge

# Oh my git
#$b arialdomartini/oh-my-git
#antigen theme arialdomartini/oh-my-git-themes arialdo-pathinline

# PowerLevel9K
# antigen theme bhilburn/powerlevel9k powerlevel9k

# Tell antigen that you're done.
antigen apply

###
#################################################################################################

# Fix vi-mode.
# function zle-line-init {
#   powerlevel9k_prepare_prompts
#   if (( ${+terminfo[smkx]} )); then
#     printf '%s' ${terminfo[smkx]}
#   fi
#   zle reset-prompt
#   zle -R
# }

# function zle-line-finish {
#   powerlevel9k_prepare_prompts
#   if (( ${+terminfo[rmkx]} )); then
#     printf '%s' ${terminfo[rmkx]}
#   fi
#   zle reset-prompt
#   zle -R
# }

# Fix vi-mode alt.
# function zle-keymap-select {
#   powerlevel9k_prepare_prompts
#   zle reset-prompt
#   zle -R
# }

# zle -N zle-line-init
# zle -N zle-line-finish
# zle -N zle-keymap-select

# Zsh git prompt
#source ~/Repositories/zsh-git-prompt/zshrc.sh
#source ~/.zsh-git-prompt

# Vi mode.
# bindkey -v
# autoload edit-command-line; zle -N edit-command-line
# bindkey -M vicmd v edit-command-line

# bind UP and DOWN arrow keys for history search plugin
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Fix ctrl+arrow keys.
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Config to make suggestion highlight visible.
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=11"

# Automatically list directory contents on `cd`.
# auto-ls () {
# 	emulate -L zsh;
# 	# explicit sexy ls'ing as aliases arent honored in here.
# 	hash gls >/dev/null 2>&1 && CLICOLOR_FORCE=1 gls -aFh --color --group-directories-first || ls
# }
#chpwd_functions=( auto-ls $chpwd_functions )

# Enable autosuggestions automatically
# zle-line-init() {
#     zle autosuggest-start
# }
#zle -N zle-line-init

# history mgmt
# http://www.refining-linux.org/archives/49/ZSH-Gem-15-Shared-history/
setopt inc_append_history
setopt share_history

# zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# uncomment to finish profiling
# zprof

# Powerline.
[ -f $PYTHON3_PACKAGES/powerline/bindings/zsh/powerline.zsh ] && source $PYTHON3_PACKAGES/powerline/bindings/zsh/powerline.zsh

