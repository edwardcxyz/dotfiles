#!/bin/zsh
echo 'Copying important dotfiles for backup...'
cp ~/.zshrc ~/dotfiles && echo '.zshrc'
cp ~/.xinitrc ~/dotfiles && echo '.xinitrc'