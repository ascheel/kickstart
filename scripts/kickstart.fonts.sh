#!/usr/bin/env bash

set -e

# This script no longer pulls dynamically.  This repo contains the fonts already.

# FONT_FILENAME="OTF-source-code-pro-2.042R-u_1.062R-i.zip"
# FONT_DIR="${HOME}/.local/share/fonts/SourceCodePro"
# mkdir -p "${FONT_DIR}"

# wget https://github.com/adobe-fonts/source-code-pro/releases/download/2.042R-u%2F1.062R-i%2F1.026R-vf/${FONT_FILENAME} -O "${TMPDIR}"/${FONT_FILENAME}
# unzip "${TMPDIR}"/${FONT_FILENAME} -d "${TMPDIR}"/source-code-pro
# sudo mv "${TMPDIR}"/source-code-pro/OTF/* "${FONT_DIR}"
# rm -rf "${TMPDIR}"/${FONT_FILENAME}
# rm -rf "${TMPDIR}"/source-code-pro

fc-cache -f -v
