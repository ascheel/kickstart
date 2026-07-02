#!/usr/bin/env bash

set -e

installer_file="${TMPDIR}"/update-golang.sh
_hash1="$(curl -s https://raw.githubusercontent.com/udhos/update-golang/master/update-golang.sh.sha256 | awk '{print $1}')"
curl -s https://raw.githubusercontent.com/udhos/update-golang/master/update-golang.sh > "${installer_file}"
_hash2="$(sha256sum "${installer_file}" | awk '{print $1}')"
if [[ "${_hash1}" != "${_hash2}" ]]; then
	echo "Hash mismatch.  Exiting."
	exit 1
fi

new_version="$(fgrep 'version=' "${installer_file}" | awk -F'=' '{print $2}')"
go_version="$(go version | awk '{print $3}')"

if [[ "${new_version}" != "${go_version}" ]]; then
	echo "Golang version mismatch.  Updating."
	sudo bash "${installer_file}"
	source /etc/profile.d/golang_path.sh
else
	echo "Golang version is already up to date."
fi
