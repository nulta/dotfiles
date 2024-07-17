#!/bin/bash

if [[ $UID != 0 ]]; then
    echo "This script requires root permission."
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
    waybar otf-font-awesome


# Setting up `greetd`
# NOTE: If you want to auto-login, edit the configuration file `/etc/greetd/config.toml`

systemctl enable greetd.service

cat > /etc/greetd/config.toml << EOF
[terminal]
vt = 1

[default_session]
command = "agretty --cmd Hyprland"
user = "greeter"

EOF


# Installation done!
echo "Installation Done!"
