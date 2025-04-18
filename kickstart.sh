#!/usr/bin/env bash

set -e

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &>/dev/null && pwd )"
CONFIGFILE="${SCRIPT_DIR}/kickstart.yml"

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
	# sudo apt update
	sudo apt upgrade -y

	# Install packages from apt
	for package in $(yq -r '.apt.packages' "${CONFIGFILE}" | jq -r "@sh" | tr -d "'"); do
		if ! dpkg -s $package >/dev/null 2>&1; then
			echo "Installing $package"
			sudo apt install -y $package
		fi
	done
fi

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
