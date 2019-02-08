news() { curl getnews.tech/$1; }

weather() { curl wttr.in/$1; }

prompt_theme() {
  if [ -f ~/.bash_themes/$1 ]; then
    export CUSTOM_PROMPT_THEME=$1
    source ~/.bashrc
  else
    if [ $1 == 'default' ]; then
      unset CUSTOM_PROMPT_THEME
      source ~/.bashrc
    else
      echo ""
      echo "No theme named '$1'"
    fi
  fi
 }

alias cat='bat'

alias ls='exa'

alias ping='prettyping'

alias top='htop'

alias preview="fzf --preview 'bat --color \"always\" {}'"
# add support for ctrl+o to open selected file in VS Code
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(code {})+abort'"
