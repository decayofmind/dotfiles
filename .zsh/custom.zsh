export PATH=/usr/local/mysql/bin:$PATH
export LC_CTYPE="en_US.UTF-8"
export WORKON_HOME=~/.virtualenvs
export EDITOR="vim"
export LESSOPEN="| /usr/local/bin/src-hilite-lesspipe.sh %s"
export LESS=" -R "
export ANSIBLE_NOCOWS=1
export HOMEBREW_GITHUB_API_TOKEN="a110e4ac10373697a0734fe62bde6eec3dfd7885"

# Pretty colors
export TERM=xterm-256color
[ -n "$TMUX"  ] && export TERM=screen-256color

bindkey '^[[Z' reverse-menu-complete

# Set vi mode
#bindkey -v

# Tun on bash style incremental search
bindkey '^R' history-incremental-search-backward

source /usr/local/share/python/virtualenvwrapper.sh
if which pyenv > /dev/null; then eval "$(pyenv init - zsh)"; fi

eval "$(thefuck --alias)"
eval "$(fasd --init posix-alias zsh-hook)"

[ -f ~/.fzf.zsh  ] && source ~/.fzf.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
