#!/usr/bin/env bash

SCRIPT_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
pushd "${SCRIPT_DIR}/../../goinventory" >/dev/null 2>&1
    make buildlinuxx86_64
    make install
popd >/dev/null 2>&1
