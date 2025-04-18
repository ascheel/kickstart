_hash1="$(curl -s https://raw.githubusercontent.com/udhos/update-golang/master/update-golang.sh.sha256 | awk '{print $1}')"
curl -s https://raw.githubusercontent.com/udhos/update-golang/master/update-golang.sh > "${TMPDIR}"/update-golang.sh
_hash2="$(sha256sum "${TMPDIR}"/update-golang.sh | awk '{print $1}')"
if [[ "${_hash1}" != "${_hash2}" ]]; then
	echo "Hash mismatch.  Exiting."
	exit 1
fi
sudo bash "${TMPDIR}"/update-golang.sh
source /etc/profile.d/golang_path.sh
