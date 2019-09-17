alias brewdump='brew bundle dump --force'
alias c='zz'
alias cat='bat -np --paging=never --theme base16'
alias diff='icdiff -N'
alias g='git'
alias htop='sudo htop'
alias ls='ls --color=auto'
alias k='kubectl'
alias kctx='kubectx'
alias kns='kubens'
alias rg='rg -i'
alias t='true'

if command -v nvim > /dev/null 2>&1; then
  alias vim='nvim'
fi
