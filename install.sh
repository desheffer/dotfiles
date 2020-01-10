#!/bin/env bash

set -e

cd "$(dirname "${0}")"

function link_file {
    # Skip if no change is needed.
    if [ "$(readlink "${2}")" == "${1}" ]; then
        return 0
    fi

    echo "Linking ${2}..."

    # Abort if the file already exists.
    if [ ! "${FORCE}" ] && [ -e "${2}" ]; then
        echo "Error: ${2} already exists!"
        return 1
    fi

    # Link the new file into place.
    mkdir -p "$(dirname "${2}")"
    ln -snf "${1}" "${2}"
}

function link_root_dir {
    echo "Linking ${1} to ${2}..."

    find "${1}" -type f -printf '%P\n' | while read file; do
        link_file "$(pwd)/${1}/${file}" "${2}/${file}"
    done
}

function exec_init {
    echo "Running init scripts..."

    find init.d -iname '*.sh' | sort | while read script; do
        . "${script}"
    done
}

[ "${1}" == "-f" ] && FORCE="1"

link_root_dir home "${HOME}"
exec_init
