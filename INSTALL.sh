#!/bin/bash

./1-install-desktop.sh
sudo ./2-system-configs.sh
./3-link-dotfiles.sh

echo "All installations done!"
