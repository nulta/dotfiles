#!/bin/bash

if [[ $UID != 0 ]]; then
    echo "This script should run with root."
    exit 1
fi


# Setting up `greetd`
# NOTE: auto-login can be configured on `/etc/greetd/config.toml`
#       file. Add a [initial_session] section like:
#
# [initial_session]
# command = "Hyprland"
# user = "yourusername"

systemctl enable greetd.service

cat > /etc/greetd/config.toml <<- EOF
    [terminal]
    vt = 1

    [default_session]
    command = "agreety --cmd Hyprland"
    user = "greeter"
EOF


echo "System configuration done!"
