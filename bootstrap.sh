#!/bin/bash

source 'scripts/helpers.sh'
source 'scripts/setup_structure.sh'

# -- Solus- or Ubuntu-Specific Setup --------------------------------------------
if system_is_OSX; then
  if test ! $(which brew)
  then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null
  fi
  brew upgrade
  brew update
  brew tap caskroom/cask
  brew install git
else
  sudo apt-get -qq update
  sudo apt-get -qq install -y git
fi


# -- Clone and symlink dotfiles repo --------------------------------------------
cd /home/$USER/code/$USER
git clone git@github.com:CharlesConner/dotfiles.git
ln -s /home/$USER/code/$USER/dotfiles /home/$USER/dotfiles
cd dotfiles && ./install.sh
