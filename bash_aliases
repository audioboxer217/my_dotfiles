news() { curl getnews.tech/$1; }

weather() { curl wttr.in/$1; }

alias cat='bat'

alias ls='exa'

alias ping='prettyping'

alias top='htop'

alias preview="fzf --preview 'bat --color \"always\" {}'"
# add support for ctrl+o to open selected file in VS Code
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(code {})+abort'"
