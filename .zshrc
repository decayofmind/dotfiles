#zmodload zsh/zprof && zprof

if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
fi

source ~/.zplug/init.zsh

zplug "zplug/zplug", hook-build:"zplug --self-manage"

#zplug "seebi/dircolors-solarized"
#zplug "seebi/dircolors-solarized", ignore:"*", as:plugin

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
#zplug "plugins/vi-mode", from:oh-my-zsh, defer:2
zplug "modules/git", from:prezto
zplug "modules/completion", from:prezto
zplug "modules/homebrew", from:prezto, if:"[[ $OSTYPE == *darwin* ]]"
zplug "modules/osx", from:prezto, if:"[[ $OSTYPE == *darwin* ]]"
zplug "plugins/docker", from:oh-my-zsh, defer:3
zplug "plugins/kubectl", from:oh-my-zsh, defer:3
zplug "plugins/helm", from:oh-my-zsh, defer:3
zplug "plugins/minikube", from:oh-my-zsh, defer:3

zplug "mafredri/zsh-async", defer:0

zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf, use:"*darwin*amd64*", if:"[[ $OSTYPE == *darwin* ]]"
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf, use:"*linux*amd64*", if:"[[ $OSTYPE == *linux* ]]"
zplug "junegunn/fzf", use:"shell/*.zsh", on:"junegunn/fzf-bin", defer:2

zplug "zsh-users/zsh-completions", defer:0
zplug "zsh-users/zsh-syntax-highlighting", defer:3
zplug "zsh-users/zsh-history-substring-search", defer:3, on:"zsh-users/zsh-syntax-highlighting"

zplug "marzocchi/zsh-notify"
zplug "modules/prompt", from:prezto
zplug "plugins/fasd", from:oh-my-zsh

# Kubernetes
zplug "dbz/zsh-kubernetes"
zplug "jonmosco/kube-ps1", use:"*.sh", defer:2
zplug "superbrothers/zsh-kubectl-prompt", defer:2
zplug "ahmetb/kubectx", use:"{kubectx,kubens}", as:command
zplug "decayofmind/kubectx", at:"feature/zplug-integration"
zplug "plugins/kubectl", from:oh-my-zsh

zplug "jingweno/ccat", \
    from:gh-r, \
    as:command, \
    use:"*linux*amd64*", \
    if:"[[ $OSTYPE == linux* ]]"

zplug "~/.zsh", from:local
zplug "/usr/share/zsh/vendor-completions", from:local, if:"[[ $OSTYPE == *linux* ]]"

zstyle ':prezto:module:prompt' theme 'sorin'
zstyle ':prezto:module:terminal' auto-title 'yes'
zstyle ':prezto:module:editor' ps-context 'yes'
zstyle ':prezto:module:editor:info:keymap:alternate' format '<<<'
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

if zplug check "zsh-users/zsh-history-substring-search"; then
  zmodload zsh/terminfo
  [ -n "${terminfo[kcuu1]}" ] && bindkey "${terminfo[kcuu1]}" history-substring-search-up
  [ -n "${terminfo[kcud1]}" ] && bindkey "${terminfo[kcud1]}" history-substring-search-down
  bindkey -M emacs '^P' history-substring-search-up
  bindkey -M emacs '^N' history-substring-search-down
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down
fi

zplug load

# Non-Zplug customizations
#set -o vi

# Unset gstat alias to make kube-ps1 work
unset -f stat

if [ $commands[stern] ]; then
  source <(stern --completion=zsh)
fi


# Variables
if [[ $(uname) == 'Linux' ]]; then
  export EDITOR="vimx"
  export VISUAL="vimx"
  alias vim="vimx"
  alias dnf="sudo dnf"
elif [[ $(uname) == 'Darwin' ]]; then
  export EDITOR="vim"
  export VISUAL="vim"
fi

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export PATH=$PATH:$ZPLUG_BIN
export ANSIBLE_NOCOWS=1

export TERM=xterm-256color
[ -n "$TMUX"  ] && export TERM=screen-256color

export KUBE_PS1_SYMBOL_DEFAULT=''
export KUBE_PS1_SEPARATOR=''
RPROMPT='$(kube_ps1) '$RPROMPT
kubeoff

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_DEFAULT_OPTS='--bind alt-j:down,alt-k:up
                         --color fg:242,bg:233,hl:65,fg+:15,bg+:234,hl+:108
                         --color info:108,prompt:109,spinner:108,pointer:168,marker:168'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"

# Aliases
alias c="zz"
alias cat="ccat"
alias htop="sudo htop"
alias ls="ls --color=auto"

weather() {
	curl "http://wttr.in/$1"
}

myip() {
	curl "ifconfig.co"
}

if (which zprof > /dev/null) ;then
  zprof | less
fi
