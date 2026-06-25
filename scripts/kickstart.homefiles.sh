#!/usr/bin/env bash

shopt -s dotglob
rsync -av "${SCRIPT_DIR}"/files/ ~/
