#!/bin/bash

if [[ $UID == 0 ]]; then
    echo "This script should not be run as root."
    exit 1
fi


ln -srb -t ~ .bash_profile
ln -srb -t ~ .bashrc
ln -srb -t ~ .profile
ln -srb -t ~/.config hypr
ln -srb -t ~/.config kitty
ln -srb -t ~/.config nano
ln -srb -t ~/.config hypr
ln -srb -t ~/.config waybar

echo "Created symbolic links!"
