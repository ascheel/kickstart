#!/usr/bin/env bash

set -e

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &>/dev/null && pwd )"

pushd () {
    # This exists just so we can suppress stdout
    command pushd "$@" >/dev/null 2>&1
}

popd () {
    # This exists just so we can suppress stdout
    command popd "$@" >/dev/null 2>&1
}

pushd ~

if [[ "$(python3 "${SCRIPT_DIR}/scripts/getos.py" --distro)" == "ubuntu" ]]
then
    # Ubuntu only
    sudo apt update
    sudo apt upgrade -y

    # Install Python3
    if ! command -v python3 > /dev/null 2>&1
    then
        echo "Python3 not installed.  Installing."
        sudo apt install -y \
            python3 \
            python3-venv \
            build-essential \
            git
    else
        echo "Python3 already installed."
    fi
    # End Install Python3
fi

# Configure git
fgrep "email =" ~/.gitconfig >/dev/null 2>&1 || git config --global user.email "ascheel@gmail.com"
fgrep "name =" ~/.gitconfig >/dev/null 2>&1 || git config --global user.name "Art Scheel"

# Configure SSH
[[ ! -d "~/.ssh" ]] && mkdir ~/.ssh
chmod 700 ~/.ssh

# Install Pip
curl -s https://bootstrap.pypa.io/get-pip.py | python3

python3 -m venv .venv
python3 -m pip install -r "${SCRIPT_DIR}/requirements.txt"

python3 "${SCRIPT_DIR}/scripts/kickstart.py"

popd
