#!/usr/bin/env zsh

weather() {
  curl "http://wttr.in/$1"
}

myip() {
  curl "ifconfig.co"
}

zbench() {
  for i in $(seq 1 10); do
    /usr/bin/time $HOMEBREW_PREFIX/bin/zsh -i -c exit
  done
}

pyenv-brew-relink() {
  rm -f "$HOME/.pyenv/versions/*-brew"

  for i in $(brew --cellar python)/*; do
    ln -s --force $i $HOME/.pyenv/versions/${i##/*/}-brew;
  done

  for i in $(brew --cellar python@2)/*; do
    ln -s --force $i $HOME/.pyenv/versions/${i##/*/}-brew;
  done
}

direnv() { asdf exec direnv "$@"; }

git-clone-bare-for-worktrees() {
  url=$1
  basename=${url##*/}
  name=${2:-${basename%.*}}

  mkdir $name
  cd "$name"

  git clone --bare "$url" .bare
  echo "gitdir: ./.bare" > .git

  # Explicitly sets the remote origin fetch so we can fetch remote branches
  git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"

  git fetch origin
}
