#!/bin/bash

H="${HOME}"

# sudo mdfind "com_apple_backup_excludeItem = 'com.apple.backupd'"
EXCLUSIONS=(
	"/Applications/"
	"/usr/local/Caskroom/"
	"/usr/local/Cellar/"
	"/usr/local/Homebrew/"
	"${H}/.asdf/"
	"${H}/.cache/"
	"${H}/.local/share/"
	"${H}/Library/Application Support/Code/"
	"${H}/Library/Application Support/Steam/SteamApps"
	"${H}/Library/Caches/"
	"${H}/Library/Group Containers/"
	"${H}/Library/Mobile Documents/"
	"${H}/Pictures/Photos Library.photoslibrary"
)

for entry in "${EXCLUSIONS[@]}"; do
	tmutil isexcluded "${entry}"
	if [[ $(tmutil isexcluded "${entry}") =~ "\[Included\]" ]]; then
		sudo tmutil addexclusion -p "${entry}"
	fi
done
