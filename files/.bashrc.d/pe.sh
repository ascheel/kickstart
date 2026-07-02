#!/bin/bash

function pe() {

    TESTFILE="/path/to/file.txt"
    echo "\$TESTFILE       = $TESTFILE"
    echo "\${TESTFILE##/}  = ${TESTFILE##/}"  # path/to/file.txt
    echo "\${TESTFILE%/*}  = ${TESTFILE%/*}"  # /path/to
    echo "\${TESTFILE%.*}  = ${TESTFILE%.*}"  # /path/to/file
    echo "\${TESTFILE##*/} = ${TESTFILE##*/}" # file.txt
    echo "\${TESTFILE##*.} = ${TESTFILE##*.}" # txt

}
