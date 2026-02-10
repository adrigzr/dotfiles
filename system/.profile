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

# Load fnm (fast node manager).
if command -v fnm >/dev/null 2>&1; then
	eval "$(fnm env --use-on-cd)"
fi

# Lazy-load rvm: add bin to PATH now, defer heavy init until first use.
if [ -f "$HOME/.rvm/scripts/rvm" ]; then
	export PATH="$PATH:$HOME/.rvm/bin"
	_load_rvm() {
		unset -f _load_rvm ruby gem rvm irb bundle rake 2>/dev/null
		source "$HOME/.rvm/scripts/rvm"
	}
	ruby()   { _load_rvm; ruby "$@"; }
	gem()    { _load_rvm; gem "$@"; }
	rvm()    { _load_rvm; rvm "$@"; }
	irb()    { _load_rvm; irb "$@"; }
	bundle() { _load_rvm; bundle "$@"; }
	rake()   { _load_rvm; rake "$@"; }
fi

# vim: ft=sh
