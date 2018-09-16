if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh
fi

source ~/.zplug/init.zsh

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_DEFAULT_OPTS='--bind alt-j:down,alt-k:up'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

zplug "zplug/zplug", hook-build:"zplug --self-manage"

zplug "seebi/dircolors-solarized"
zplug "seebi/dircolors-solarized", ignore:"*", as:plugin

zstyle ':prezto:*:*' color 'yes'
zstyle ':completion:*' menu select

zplug "modules/environment", from:prezto
zplug "modules/terminal", from:prezto
zplug "modules/editor", from:prezto
zplug "modules/history", from:prezto
zplug "modules/directory", from:prezto
zplug "modules/gnu-utility", from:prezto, if:"[[ $OSTYPE == *darwin* ]]"
zplug "modules/utility", from:prezto
zplug "modules/python", from:prezto
zplug "plugins/pyenv", from:oh-my-zsh
zplug "modules/git", from:prezto
zplug "modules/completion", from:prezto
zplug "modules/prompt", from:prezto

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:3


zplug "plugins/fasd", from:oh-my-zsh

# Kubernetes
zplug "dbz/zsh-kubernetes"
zplug "jonmosco/kube-ps1", use:"*.sh", defer:1
zplug "superbrothers/zsh-kubectl-prompt", defer:2
zplug "ahmetb/kubectx", use:"{kubectx,kubens}", as:command
zplug "decayofmind/kubectx", at:"feature/zplug-integration"

zplug "junegunn/fzf", use:"shell/key-bindings.zsh", defer:1

zplug "jingweno/ccat", \
    from:gh-r, \
    as:command, \
    use:"*linux*amd64*", \
    if:"[[ $OSTYPE == linux* ]]"

zplug "~/.zsh", from:local
zplug "/usr/share/zsh/vendor-completions", from:local

zstyle ':prezto:module:prompt' theme 'sorin'
zstyle ':prezto:module:terminal' auto-title 'yes'
zstyle ':prezto:module:terminal:window-title' format '%n@%m: %s'
zstyle ':prezto:module:terminal:tab-title' format '%m: %s'

# Install packages that have not been installed yet
if ! zplug check; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    else
        echo
    fi
fi

zplug load


if zplug check "zsh-users/zsh-history-substring-search"; then
  zmodload zsh/terminfo
  [ -n "${terminfo[kcuu1]}" ] && bindkey "${terminfo[kcuu1]}" history-substring-search-up
  [ -n "${terminfo[kcud1]}" ] && bindkey "${terminfo[kcud1]}" history-substring-search-down
  bindkey -M emacs '^P' history-substring-search-up
  bindkey -M emacs '^N' history-substring-search-down
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down
fi


# Non-Zplug customizations

if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi

if [ $commands[helm] ]; then
  source <(helm completion zsh)
fi

if [ $commands[minikube] ]; then
  source <(minikube completion zsh)
fi

# Variables
if [[ $(uname) == 'Linux' ]]; then
  export EDITOR="vimx"
  export VISUAL="vimx"
  alias vim="vimx"
elif [[ $(uname) == 'Darwin' ]]; then
  export EDITOR="vim"
  export VISUAL="vim"
fi
export PATH=$PATH:$ZPLUG_BIN
export ANSIBLE_NOCOWS=1

export TERM=xterm-256color
[ -n "$TMUX"  ] && export TERM=screen-256color

export KUBE_PS1_SYMBOL_DEFAULT=''
export KUBE_PS1_SEPARATOR=''
RPROMPT='$(kube_ps1) '$RPROMPT
kubeoff


# Aliases
alias c="zz"

alias cat="ccat"
alias htop="sudo htop"
alias dnf="sudo dnf"

weather() {
	curl "http://wttr.in/$1"
}

myip() {
	curl "ifconfig.co"
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
