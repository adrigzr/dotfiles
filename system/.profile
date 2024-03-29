# Load our dotfiles like $HOME/.bash_prompt, etc…
#   $HOME/.extra can be used for settings you don’t want to commit,
#   Use it to configure your PATH, thus it being first in line.
for file in $HOME/.{exports,aliases,functions,extra}; do
    [ -r "$file" ] && source "$file"
done
unset file

# generic colouriser
GRC=`which grc`
if [ "$TERM" != dumb ] && [ -n "$GRC" ]
    then
        alias colourify="$GRC -es --colour=auto"
        alias configure='colourify ./configure'
        for app in {diff,gcc,g++,ping,traceroute}; do
            alias "$app"='colourify '$app
    done
fi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Load nvm.
# export NVM_DIR="$HOME/.config/nvm"
# [ -f "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm

# Load rvm.
[ -f "$HOME/.rvm/scripts/rvm" ] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Load rust.
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# Load travis.
[ -f "$HOME/.travis/travis.sh" ] && source "$HOME/.travis/travis.sh"

# Load jabba.
[ -f "$HOME/.jabba/jabba.sh" ] && source "$HOME/.jabba/jabba.sh" >/dev/null

# vim: ft=sh
