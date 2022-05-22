#!/bin/bash

# sudo mdfind "com_apple_backup_excludeItem = 'com.apple.backupd'"
EXCLUSIONS=(
	"/Applications/"
	"/usr/local/Caskroom/"
	"/usr/local/Cellar/"
	"/usr/local/Homebrew/"
	"${HOME}/.asdf/"
	"${HOME}/.cache/"
	"${HOME}/.local/share/"
	"${HOME}/Library/Application\ Support/Code/"
	"${HOME}/Library/Application\ Support/Steam/SteamApps"
	"${HOME}/Library/Caches/"
	"${HOME}/Library/Group\ Containers/"
	"${HOME}/Library/Mobile\ Documents/"
	"${HOME}/Pictures/Photos\ Library.photoslibrary"
)

for entry in "${EXCLUSIONS[@]}"; do
	sudo tmutil addexclusion -p "${entry}"
done
