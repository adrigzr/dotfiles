# Load our dotfiles like $HOME/.exports, etc…
#   $HOME/.extra can be used for settings you don't want to commit,
#   Use it to configure your PATH, thus it being first in line.
for file in "$HOME"/.{exports,aliases,functions,extra}; do
	[ -r "$file" ] && source "$file"
done
unset file

# generic colouriser
GRC=$(command -v grc)
if [ "$TERM" != dumb ] && [ -n "$GRC" ]; then
	alias colourify="$GRC -es --colour=auto"
	alias configure='colourify ./configure'
	for app in {diff,gcc,g++,ping,traceroute}; do
		alias "$app"='colourify '$app
	done
fi

# History settings.
export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=100000
export HISTFILESIZE=$HISTSIZE
shopt -s histappend

# Save and reload the history after each command finishes.
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Check the window size after each command.
shopt -s checkwinsize

# Case-insensitive globbing (used in pathname expansion).
shopt -s nocaseglob

# Autocorrect typos in path names when using `cd`.
shopt -s cdspell

# Enable tab completion for `g` by marking it as an alias for `git`.
if type __git_complete &>/dev/null; then
	__git_complete g __git_main
fi

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards.
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

# Enable programmable completion features.
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

# Load fzf (fuzzy-finder).
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Load fnm (fast node manager).
if command -v fnm >/dev/null 2>&1; then
	eval "$(fnm env --use-on-cd)"
fi

# Lazy-load rvm (only when first invoked).
if [ -d "$HOME/.rvm/bin" ]; then
	export PATH="$PATH:$HOME/.rvm/bin"
	rvm() {
		unset -f rvm
		source "$HOME/.rvm/scripts/rvm"
		rvm "$@"
	}
fi

# Starship prompt.
if command -v starship >/dev/null 2>&1; then
	eval "$(starship init bash)"
fi

# vim: ft=sh
