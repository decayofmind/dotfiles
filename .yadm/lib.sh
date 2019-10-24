#!/bin/bash

function install_brew() {
  if ! command -v brew >/dev/null 2>&1; then
    echo "Installing homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  if [ -f "$HOME/.Brewfile" ]; then
    echo "Updating homebrew bundle"
    brew bundle --global
    # controll yadm with brew
    brew link --overwrite yadm
  fi
}

function install_npm() {
  local NPM_PACKAGES=(
    bash-language-server
    dockerfile-language-server-nodejs
    fixjson
    neovim
    prettier
    yaml-language-server
  )

  if command -v npm >/dev/null 2>&1; then
    for package in "${NPM_PACKAGES[@]}"; do
      npm install -g "$package"
    done
  fi
}

function install_fonts() {
  \cp "$HOME"/.fonts/* "$HOME/Library/Fonts/"
}

function install_defaults() {
  # shellcheck source=../.macos/defaults.sh
  source "$HOME/.macos/defaults.sh"
}

function install_plists() {
  for plist in "$HOME"/.macos/*.plist; do
    \cp "$plist" "$HOME/Library/Preferences/"
  done
}

function export_plists() {
  for plist in "$HOME"/.macos/*.plist; do
    \cp "$HOME/Library/Preferences/${plist##*/}"  "$HOME/.macos/"
  done
}
