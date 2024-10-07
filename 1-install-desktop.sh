#!/bin/bash

if [[ $UID == 0 ]]; then
    echo "This script should not be run as root."
    exit 1
fi

yay --noconfirm -Syu \
    hyprland \
    polkit polkit-kde-agent \
    swaync \
    pipewire \
    wireplumber \
    qt5-wayland qt6-wayland \
    xdg-desktop-portal-hyprland xdg-desktop-portal-gtk \
    kitty dolphin \
    nwg-drawer-bin \
    greetd \
    otf-font-awesome \
    hyprpaper hypridle hyprlock \
    grim slurp wl-clipboard \
    fprint brightnessctl \
    fcitx5 fcitx5-im fcitx5-hangul \
    aylurs-gtk-shell

# Installation done!
echo "Desktop Installation Done!"
