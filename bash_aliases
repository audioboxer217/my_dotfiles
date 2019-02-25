news() { curl getnews.tech/$1; }

weather() { curl wttr.in/$1; }

prompt_theme() {
  if [ -f ~/.bash_themes/$1 ]; then
    echo $1 > ~/.bash_prompt_theme
    source ~/.bashrc
  else
    if [ $1 == 'default' ]; then
      unset CUSTOM_PROMPT_THEME
      rm ~/.bash_prompt_theme
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

alias powershell='/usr/local/microsoft/powershell/6/pwsh'

# MAC OS Only
alias fresh_brew='brew update && brew upgrade && brew cleanup && brew doctor'
