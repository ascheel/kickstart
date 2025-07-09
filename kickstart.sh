#!/usr/bin/env bash

set -e

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &>/dev/null && pwd )"
CONFIGFILE="${SCRIPT_DIR}/kickstart.yml"
YQ_VERSION="v4.45.2"
YQ_PACKAGE="yq_linux_amd64"
YQ_DESTINATION="${HOME}/.local/bin/yq"

pushd () {
	# This exists just so we can suppress stdout
	command pushd "$@" >/dev/null 2>&1
}

popd () {
	# This exists just so we can suppress stdout
	command popd "$@" >/dev/null 2>&1
}

install_yq_jq() {
	if ! which yq >/dev/null 2>&1; then
		echo "Installing yq"
		sudo curl -L https://github.com/mikefarah/yq/releases/latest/download/${YQ_PACKAGE} -o "${YQ_DESTINATION}" && \
		sudo chmod +x "${YQ_DESTINATION}"
	fi
	if ! which jq >/dev/null 2>&1; then
		echo "Installing jq"
		sudo apt install -y jq
	fi
}

if [[ "$(python3 "${SCRIPT_DIR}/scripts/getos.py" --distro)" == "ubuntu" ]]
then
	# Ubuntu only
	# Check if apt update was run in the last 30 minutes
	APT_UPDATE_FILE="/var/lib/apt/periodic/update-success-stamp"
	if [[ ! -f "$APT_UPDATE_FILE" ]] || [[ $(($(date +%s) - $(stat -c %Y "$APT_UPDATE_FILE"))) -gt 1800 ]]; then
		echo "Running apt update (last update was more than 30 minutes ago)"
		sudo apt update
		sudo touch "$APT_UPDATE_FILE"
	else
		echo "Skipping apt update (last update was less than 30 minutes ago)"
	fi
	sudo apt upgrade -y
	
	# Install yq and jq now because they're needed for the rest of the script
	install_yq_jq

	# Install packages from apt
	for package in $(yq -r '.apt.packages' "${CONFIGFILE}" -o json | jq -r "@sh" | tr -d "'"); do
		echo "Checking if $package is installed"
		if ! dpkg -s $package >/dev/null 2>&1; then
			echo "Installing $package"
			sudo apt install -y $package
		fi
	done
fi

pushd ~

# Create tmp directory
export TMPDIR="${SCRIPT_DIR}"/tmp
[[ ! -d "${TMPDIR}" ]] && mkdir "${TMPDIR}"
# [[ ! -d "${SCRIPT_DIR}"/tmp ]] && mkdir "${SCRIPT_DIR}"/tmp

# Install Golang
source $SCRIPT_DIR/scripts/kickstart.golang.sh

# .bashrc.d
source $SCRIPT_DIR/scripts/kickstart.bashrcd.sh

# Configure SSH
source $SCRIPT_DIR/scripts/kickstart.ssh.sh

# Configure git
source $SCRIPT_DIR/scripts/kickstart.git.sh

popd
