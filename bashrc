# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
      color_prompt=yes
    else
      color_prompt=
    fi
fi

# define text formatting
PROMPT_BOLD="$(tput bold)"
PROMPT_UNDERLINE="$(tput smul)"
PROMPT_RESET="$(tput sgr0)"

# set the input prompt symbol
ARROW="❯"
GIT_ICON="⌥ "
LOC_ICON="💻"
DIR_ICON="📁"

# prompt sections
if [ "$color_prompt" = yes ]; then
  PROMPT_FG_GREEN="$(tput setaf 2)"
  PROMPT_FG_CYAN="$(tput setaf 6)"
  PROMPT_FG_YELLOW="$(tput setaf 3)"
  PROMPT_FG_MAGENTA="$(tput setaf 5)"
  PROMPT_SECTION_LOCATION="$LOC_ICON \[$PROMPT_BOLD$PROMPT_FG_GREEN\]\u@\h\[$PROMPT_RESET\]"
  PROMPT_SECTION_DIRECTORY="$DIR_ICON \[$PROMPT_UNDERLINE$PROMPT_FG_CYAN\]\W\[$PROMPT_RESET\]"
  PROMPT_SECTION_ARROW="\[$PROMPT_FG_MAGENTA\]$ARROW\[$PROMPT_RESET\]"
else
  PROMPT_SECTION_LOCATION="$LOC_ICON \[$PROMPT_BOLD\]\u@\h\[$PROMPT_RESET\]"
  PROMPT_SECTION_DIRECTORY="$DIR_ICON \[$PROMPT_UNDERLINE\]\W\[$PROMPT_RESET\]"
  PROMPT_SECTION_ARROW="$ARROW"
fi

# set the prompt string using each section variable
PS1="
$PROMPT_SECTION_LOCATION $PROMPT_SECTION_DIRECTORY
$PROMPT_SECTION_ARROW "

unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

source <(kubectl completion bash)
alias k='kubectl'
alias kn='kubectl config set-context --current --namespace '