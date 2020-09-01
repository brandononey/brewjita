!/usr/bin/env bash
#
#  --------------------------------------------------------------
# |      ______                        ___  _  _                 |
# |      | ___ \                      |_  |(*)| |                |
# |      | |_/ / _ __  ___ __      __   | | _ | |_  __ _  v1.0   |
# |      | ___ \| '__|/ _ \\ \ /\ / /   | || || __|/ _` |        |
# |      | |_/ /| |  |  __/ \ V  V //\__/ /| || |_| (_| |        |
# |      \____/ |_|   \___|  \_/\_/ \____/ |_| \__|\__,_|        |
# |                                                              |
# |   ~ a magic lil' script to make macOS feel more like home ~  |
# |                                                              |
# |                                https://github.com/clairelet  |
#  --------------------------------------------------------------
#
# enable tap ta' click
echo "making the trackpad a little more magical..."
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
#
# display all filename extensions in finder by default
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
#
# check for homebrew - install if not found
if test ! $(which brew); then
    echo "~ this round's on me- installing homebrew ~"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else echo "~ this round's on you- homebrew already installed ~"
fi
#
# update homebrew
brew update
#
# tap the cask repo
brew tap "homebrew/cask"
#
# set arguments for all 'brew cask install' commands
cask_args appdir: "~/Applications"
#
echo "soon your mac will feel brand GNU..."
brew install coreutils
brew install moreutils
brew install findutils
#
# Define packages (CLI) for installation 
PACKAGES=(
	awscli
	geoip
	git
	htop
	irssi
	nmap
	wget
)
#
echo "Brewing packages..."
brew install ${PACKAGES[@]}
#
echo "Cleaning up spills..."
brew cleanup
#
# Define casks (GUI) for installation
CASKS=(
	amazon-chime
	burp-suite
	firefox
	github-desktop
	google-chrome
	google-drive-file-stream
	iterm2
	maltego
	malwarebytes
	metasploit
	protonvpn
	slack
	sublime-text
	the-unarchiver
	visual-studio-code
	vlc
	vmware-fusion
)
#
echo "Pouring the casks..."
brew cask install ${CASKS[@]}
#
# 'brew cask install --appdir=~/my-apps/Applications'
#cask "firefox", args: { appdir: "~/my-apps/Applications" }
# 'brew cask install' only if '/usr/libexec/java_home --failfast' fails
#cask "java" unless system "/usr/libexec/java_home --failfast"
# 'mas install'
#mas "1Password", id: