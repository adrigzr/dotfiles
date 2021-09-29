# Load plugin.
autoload -U promptinit; promptinit

# Select prompt.
prompt spaceship

# Configuration.
SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  # hg            # Mercurial section (hg_branch  + hg_status)
  package       # Package version
  node          # Node.js section
  # ruby          # Ruby section
  # elixir        # Elixir section
  # xcode         # Xcode section
  # swift         # Swift section
  # golang        # Go section
  # php           # PHP section
  # rust          # Rust section
  # haskell       # Haskell Stack section
  # julia         # Julia section
  # docker        # Docker section
  # aws           # Amazon Web Services section
  venv          # virtualenv section
  # conda         # conda virtualenv section
  # pyenv         # Pyenv section
  # dotnet        # .NET section
  # ember         # Ember.js section
  # kubecontext   # Kubectl context section
  exec_time     # Execution time
  line_sep      # Line break
  battery       # Battery level and status
  jobs          # Backgound jobs indicator
  char          # Prompt character
)

SPACESHIP_RPROMPT_ORDER=(
  vi_mode       # Vi-mode indicator
  exit_code     # Exit code section
  time          # Time stampts section
)

SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_TIME_SHOW=true
SPACESHIP_VI_MODE_SHOW=true
SPACESHIP_VI_MODE_INSERT="I"
SPACESHIP_VI_MODE_NORMAL="N"
SPACESHIP_VI_MODE_COLOR=blue
SPACESHIP_EXIT_CODE_PREFIX="with "
SPACESHIP_DIR_TRUNC=2
SPACESHIP_DIR_TRUNC_REPO=false
SPACESHIP_EXIT_CODE_SHOW=true
SPACESHIP_EXIT_CODE_SYMBOl="✘ "
SPACESHIP_JOBS_COLOR=magenta
SPACESHIP_GIT_STATUS_DELETED="✘ "
SPACESHIP_GIT_STATUS_AHEAD="⇡ "
SPACESHIP_GIT_STATUS_BEHIND="⇣ "
SPACESHIP_GIT_STATUS_DIVERGED="⇕ "
# SPACESHIP_NODE_DEFAULT_VERSION=$(awk '{ print "v" $0 ".0" }' $NVM_DIR/alias/default)
SPACESHIP_DOCKER_SHOW=false
