#!/usr/bin/env bash

set -e

shopt -s dotglob
rsync -aiv "${SCRIPT_DIR}"/files/ ~/
