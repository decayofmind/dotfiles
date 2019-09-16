#!/usr/bin/env zsh
# vim:syntax=zsh
# vim:filetype=zsh

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export VISUAL=vim
if command -v nvim > /dev/null 2>&1; then
  export VISUAL=nvim
fi
export EDITOR=$VISUAL

# Setup ZSH cache directory
export ZSH_CACHE_DIR="$HOME/.cache/zsh"
if [[ ! -d "$ZSH_CACHE_DIR" ]]; then
  /bin/mkdir -p "$ZSH_CACHE_DIR"
  /bin/chmod 0700 "$ZSH_CACHE_DIR"
fi

# eliminates duplicates in *paths
typeset -gU cdpath fpath path

# Zsh search path for executable
path=(
  /usr/local/{bin,sbin}
  $path
)
