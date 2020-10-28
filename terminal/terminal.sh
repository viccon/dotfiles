#!/bin/bash

echo_header "Terminal configuration"

echo_item "Symlinking GTK styles for the terminal" "green"
ln -sfn ~/dotfiles/terminal/gtk.css ~/.config/gtk-3.0/gtk.css

echo_item "Setting up terminal colors" "green"
infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > $TERM.ti
tic $TERM.ti
rm $TERM.ti

# Cant query gnome terminal for profile names
PROFILE_FILE=~/.config/dotfile-installs/palenightprofile
if [[ -f  "$PROFILE_FILE" ]]; then
  echo_item "Palenight profile is already created" "green"
else
  echo_item "Installing palenight profile" "green"
  git clone --quiet https://github.com/devaddict/terminal-scheme --depth=1
  cd terminal-scheme
  ./palenight.sh
  cd -
  rm -rf terminal-scheme
  touch $PROFILE_FILE
fi

echo ""
