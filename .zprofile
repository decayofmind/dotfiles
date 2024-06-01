export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# XDG
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# Setup ZSH cache directory
export ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh"
if [[ ! -d "$ZSH_CACHE_DIR" ]]; then
  /bin/mkdir -p "$ZSH_CACHE_DIR"
  /bin/chmod 0700 "$ZSH_CACHE_DIR"
fi

# Go lang settings
export GOPATH="${HOME}/.go"

# Zsh search path for executable
path=(
  $HOME/.local/bin
  ${GOPATH}/bin
  /usr/local/opt/node@10/bin
  /usr/local/{bin,sbin}
  /opt/homebrew/{bin,sbin}
  $path
)

fpath=(
  $HOME/.zsh/completions
  $ZSH_CACHE_DIR/completions
  $fpath
)

# Eliminates duplicates in *paths
typeset -gU cdpath fpath path

# Editor
export VISUAL=vim
if command -v nvim > /dev/null 2>&1; then
  export VISUAL=nvim
fi
export EDITOR=$VISUAL

if command -v kubectl-krew > /dev/null 2>&1; then
  path+=("$HOME/.krew/bin")
fi

# Set base16 theme
export BASE16_THEME='black-metal-khold'
