#!/usr/bin/env bash

set -o errexit

function print_debug {
    if [ ! -z ${DEBUG} ]; then
        echo "[DEBUG] $@"
    fi
}

if [ -z ${X_COOKIE} ]; then
    echo "X-COOKIE not set, this is required to show a GUI."
else
    print_debug "X-COOKIE: $X_COOKIE"
    xauth add $DISPLAY . $X_COOKIE
fi

/app/application.py $@
