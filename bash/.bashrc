# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Load bash_profile.
[ -n "$PS1" ] && source ~/.bash_profile
