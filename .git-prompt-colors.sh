# This is an alternative approach. Single line in git repo.
override_git_prompt_colors() {
  GIT_PROMPT_THEME_NAME="Custom"

  GIT_PROMPT_CONFLICTS="${Red}✖"       # the number of files in conflict
  GIT_PROMPT_CHANGED="${Blue}✚"        # the number of changed files
  GIT_PROMPT_STASHED="${BoldBlue}⚑"    # the number of stashed files/dir
  GIT_PROMPT_STAGED="${Green}●"           # the number of staged files/directories
  GIT_PROMPT_SYMBOLS_AHEAD="${BoldRed}↑"             # The symbol for "n versions ahead of origin"
  GIT_PROMPT_SYMBOLS_BEHIND="${BoldGreen}↓"            # The symbol for "n versions behind of origin"

  GIT_PROMPT_START_USER="_LAST_COMMAND_INDICATOR_ ${BoldGreen}${PathShort}${ResetColor}"

  GIT_PROMPT_END_USER=""

  if (( "$(tput cols)" < 100 )); then
    GIT_PROMPT_END_USER+="\n"
  fi

  GIT_PROMPT_END_USER+="${ResetColor} $ "
  GIT_PROMPT_END_ROOT="${BoldRed} # "

  #Overrides the prompt_callback function used by bash-git-prompt
  function prompt_callback {
    gp_set_window_title $(gp_truncate_pwd)
  }
}

reload_git_prompt_colors "Custom"

