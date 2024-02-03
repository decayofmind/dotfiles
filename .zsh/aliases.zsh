alias bootstrap='$HOME/.yadm/bootstrap'
alias brewdump='brew bundle dump --force --global'
alias ap='aws-profile'
alias c='z'
alias ci='zi'
alias cdp='cdproject'
alias cat='bat -pp --theme base16'
alias diff='icdiff -N'
alias dmesg='sudo dmesg'
alias htop='sudo htop'
alias ls='exa'
alias l='ls'
alias rg='rg -i'
alias t='true'
alias tf='terraform'
alias tree='exa --tree'
alias ym='yadm'
alias workoff='deactivate'
alias zreload='exec $SHELL -l'

# Helm
alias h='helm'
alias hdu='h dep up'
alias hrl='h repo list'
alias hid='h install --debug --dry-run'

# Kubectl
alias kctx='kubectx'
alias kns='kubens'
alias kx='kctx'
alias kn='kns'
alias kgjs='k get jobs'
alias kb='kustomize build --load-restrictor=LoadRestrictionsNone ./ --stack-trace | cat --language=yaml'

if command -v nvim > /dev/null 2>&1; then
  alias vim='nvim'
  alias vi='nvim'
  alias vimdiff='nvim -d'
fi
