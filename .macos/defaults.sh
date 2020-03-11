#!/usr/local/bin/zsh

# Globals
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool true
defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false
defaults write -globalDomain AppleKeyboardUIMode -int 3

# Dock
defaults write com.apple.dock autohide -bool true;
defaults write com.apple.dock static-only -bool true;
defaults write com.apple.dock tilesize -integer 32;
defaults write com.apple.dock autohide-time-modifier -float 1;
killall Dock

# Finder
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
killall Finder


# iTerm2

defaults write com.apple.LaunchServices/com.apple.launchservices.secure LSHandlers -array-add '{
  LSHandlerContentType = "public.unix-executable";
  LSHandlerRoleShell = "com.googlecode.iterm2";
}'
defaults write com.googlecode.iterm2 SUEnableAutomaticChecks -bool true
defaults write com.googlecode.iterm2 SUAutomaticallyUpdate -bool true
defaults write com.googlecode.iterm2 TabStyleWithAutomaticOption -int 5
defaults write com.googlecode.iterm2 TabsHaveCloseButton -bool false
defaults write com.googlecode.iterm2 HideScrollbar -bool true
defaults write com.googlecode.iterm2 HideTabNumber -bool true
defaults write com.apple.LaunchServices/com.apple.launchservices.secure LSHandlers -array-add '{
  LSHandlerContentType = "ssh";
  LSHandlerRoleAll = "com.googlecode.iterm2";
}'
defaults write com.googlecode.iterm2 "Default Bookmark Guid" \
  -string "FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF"

# shellcheck source=../.zprofile
eval $(source "$HOME/.zprofile"; echo _BASE16_THEME="$BASE16_THEME";)
curl -L "https://github.com/martinlindhe/base16-iterm2/raw/master/itermcolors/base16-$_BASE16_THEME-256.itermcolors" > "$HOME/.macos/tmp.itermcolors"

open "$HOME/.macos/tmp.itermcolors"

rm -rf "$HOME/.macos/tmp.itermcolors"
