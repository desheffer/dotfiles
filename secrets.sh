#!/bin/env bash

set -euo pipefail

readonly prefix="Dotfiles/"

function path_to_key {
    path="${1}"

    rel=$(realpath --relative-base="${HOME}" --strip "${path}")
    if [[ "${rel}" =~ ^/ ]]; then
        echo "\$ROOT${rel}"
    else
        echo "\$HOME/${rel}"
    fi
}

function key_to_path {
    key="${1}"

    if [[ "${key}" =~ ^\$ROOT ]]; then
        echo "${key/\$ROOT/}"
    elif [[ "${key}" =~ ^\$HOME ]]; then
        echo "${key/\$HOME/$HOME}"
    else
        echo "${0}: unknown key format '${key}'" >/dev/stderr
        exit 1
    fi
}

function show_help {
    echo "Usage: ${0} ls"
    echo "  or:  ${0} get"
    echo "  or:  ${0} put FILE"
    echo "Manage secrets using LastPass."
    exit 0
}

function do_list {
    lpass ls "${prefix}" | sed -n "s|^${prefix}\(.\+\) \[.*\]|\1|p"
}

function do_get {
    list=$(do_list)

    IFS=$'\n'
    for key in $list; do
        path=$(key_to_path "${key}")

        if [ -e "${path}" ]; then
            echo "Skipped '${key}'" >/dev/stderr
            continue
        fi

        mkdir -p "$(dirname "${path}")"
        lpass show --notes "${prefix}${key}" >"${path}"
        chmod 0600 "${path}"

        echo "Downloaded '${key}' -> '${path}'" >/dev/stderr
    done
}

function do_put {
    path="${1}"
    key=$(path_to_key "${path}")

    lpass edit --non-interactive --notes "${prefix}${key}" <"${path}"

    echo "Uploaded '${path}' -> '${key}'" >/dev/stderr
}

case "${1:-}" in
    ls)
        do_list
        ;;

    get)
        do_get
        ;;

    put)
        if [[ $# -lt 2 ]]; then
            echo "${0}: missing file operand" >/dev/stderr
            exit 1
        fi

        if [ ! -f "${2}" ]; then
            echo "${0}: cannot upload '${2}': Not a file" >/dev/stderr
            exit 1
        fi

        do_put "$2"
        ;;

    *)
        show_help
        ;;
esac
