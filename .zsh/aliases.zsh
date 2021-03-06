alias bootstrap='$HOME/.yadm/bootstrap'
alias brewdump='brew bundle dump --force --global'
alias c='zz'
alias cdp='cdproject'
alias cat='bat -np --paging=never --theme base16'
alias diff='icdiff -N'
alias dmesg='sudo dmesg'
alias helm2='/usr/local/opt/helm@2/bin/helm'
alias htop='sudo htop'
alias ls='exa'
alias k='kubectl'
alias kctx='kubectx'
alias kns='kubens'
alias kubeon='kpst'
alias rg='rg -i'
alias t='true'
alias tf='terraform'
alias tree='exa --tree'
alias ym='yadm'
alias workoff='deactivate'
alias zreload='exec $SHELL -l'

if command -v nvim > /dev/null 2>&1; then
  alias vim='nvim'
  alias vimdiff='nvim -d'
fi

unalias sl
