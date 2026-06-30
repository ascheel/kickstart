DROPBOX_FILENAME="dropbox_2026.05.06_amd64.deb"
wget https://www.dropbox.com/download?dl=packages/ubuntu/${DROPBOX_FILENAME} -O "${TMPDIR}"/${DROPBOX_FILENAME}
sudo dpkg -i "${TMPDIR}"/${DROPBOX_FILENAME}
rm "${TMPDIR}"/${DROPBOX_FILENAME}
