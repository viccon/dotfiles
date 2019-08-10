#!/bin/bash

source 'scripts/helpers.sh'

echo_header "NVIM Configuration"

echo_item "Symlinking nvim configuration" "green"
rm -rf $HOME/.config/nvim
ln -sfn $HOME/dotfiles/nvim $HOME/.config/nvim

echo_item "Installing NVIM plugins"
nvim "+PlugInstall" +qall

echo_item "Updating NVIM plugins"
nvim "+PlugUpdate" +qall

echo_item "Installing coc sources"
nvim "+CocInstall coc-tsserver coc-eslint coc-json coc-prettier coc-css coc-emoji" +qall

echo ""
