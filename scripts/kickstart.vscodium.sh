#!/usr/bin/env bash

set -e

#https://vscodium.com/#install-on-debian-ubuntu-deb-package

if codium -v >/dev/null 2>&1
then
    echo "VSCodium is already installed"
    exit 0
fi

if [[ ! -f /usr/share/keyrings/vscodium-archive-keyring.gpg ]]
then
    wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
        | gpg --dearmor \
        | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg
fi

if [[ ! -f /etc/apt/sources.list.d/vscodium.sources ]]
then
    echo -e 'Types: deb\nURIs: https://download.vscodium.com/debs\nSuites: vscodium\nComponents: main\nArchitectures: amd64 arm64\nSigned-by: /usr/share/keyrings/vscodium-archive-keyring.gpg' \
        | sudo tee /etc/apt/sources.list.d/vscodium.sources
fi

sudo apt update
sudo apt install codium
