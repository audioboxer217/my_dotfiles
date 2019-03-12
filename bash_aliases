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
