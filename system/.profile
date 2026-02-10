# Load our dotfiles like $HOME/.bash_prompt, etc…
#   $HOME/.extra can be used for settings you don’t want to commit,
#   Use it to configure your PATH, thus it being first in line.
for file in $HOME/.{exports,aliases,functions,extra}; do
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

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Load fnm (fast node manager).
if command -v fnm >/dev/null 2>&1; then
	eval "$(fnm env --use-on-cd)"
fi

# Load rvm.
if [ -f "$HOME/.rvm/scripts/rvm" ]; then
	export PATH="$PATH:$HOME/.rvm/bin"
	source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
fi

# vim: ft=sh
