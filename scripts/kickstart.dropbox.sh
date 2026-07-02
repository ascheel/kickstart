DROPBOX_VERSION="2026.05.06"
if ! dropbox version | grep "$DROPBOX_VERSION" >/dev/null 2>&1
then
    DROPBOX_FILENAME="dropbox_${DROPBOX_VERSION}_amd64.deb"
    DROPBOX_URL="https://www.dropbox.com/download?dl=packages/ubuntu/${DROPBOX_FILENAME}"
    wget ${DROPBOX_URL} -O "${TMPDIR}"/${DROPBOX_FILENAME}
    sudo dpkg -i "${TMPDIR}"/${DROPBOX_FILENAME}
    rm "${TMPDIR}"/${DROPBOX_FILENAME}
else
    echo "Dropbox version $DROPBOX_VERSION is already installed"
fi
