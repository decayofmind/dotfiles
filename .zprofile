#!/usr/bin/env zsh
# vim:syntax=zsh
# vim:filetype=zsh

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export VISUAL=vim
export EDITOR=$VISUAL

# eliminates duplicates in *paths
typeset -gU cdpath fpath path

# Zsh search path for executable
path=(

  /usr/local/{bin,sbin}
  $path
)
