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
    echo "  or:  ${0} put FILE..."
    echo "  or:  ${0} rm KEY..."
    echo "Manage secrets using LastPass."
    exit 0
}

function do_list {
    lpass ls "${prefix}" | sed -n "s|^${prefix}\(.\+\) \[.*\]|\1|p"
}

function do_get {
    key="${1}"
    path=$(key_to_path "${key}")

    if [ -e "${path}" ]; then
        echo "${0}: skipped '${key}'" >/dev/stderr
        return
    fi

    mkdir -p "$(dirname "${path}")"
    lpass show --notes "${prefix}${key}" >"${path}"
    chmod 0600 "${path}"

    echo "${0}: downloaded '${key}' -> '${path}'" >/dev/stderr
}

function do_put {
    path="${1}"
    key=$(path_to_key "${path}")

    lpass edit --non-interactive --notes "${prefix}${key}" <"${path}"

    echo "${0}: uploaded '${path}' -> '${key}'" >/dev/stderr
}

function do_rm {
    key="${1}"

    lpass rm "${prefix}${key}"

    echo "${0}: removed '${key}'" >/dev/stderr
}

case "${1:-}" in
    ls)
        if [[ $# -ne 1 ]]; then
            echo "${0}: invalid operand" >/dev/stderr
            exit 1
        fi

        do_list
        ;;

    get)
        if [[ $# -ne 1 ]]; then
            echo "${0}: invalid operand" >/dev/stderr
            exit 1
        fi

        IFS=$'\n'
        for key in $(do_list); do
            do_get "${key}"
        done
        ;;

    put)
        if [[ $# -lt 2 ]]; then
            echo "${0}: missing file operand" >/dev/stderr
            exit 1
        fi

        for path in "${@:2}"; do
            if [ ! -f "${path}" ]; then
                echo "${0}: cannot upload '${path}': Not a file" >/dev/stderr
                exit 1
            fi
        done

        for path in "${@:2}"; do
            do_put "${path}"
        done
        ;;

    rm)
        if [[ $# -lt 2 ]]; then
            echo "${0}: missing file operand" >/dev/stderr
            exit 1
        fi

        for key in "${@:2}"; do
            if [ -z "$(do_list | grep -Fx "${key}")" ]; then
                echo "${0}: cannot remove '${key}': Key does not exist" >/dev/stderr
                exit 1
            fi
        done

        for key in "${@:2}"; do
            do_rm "${key}"
        done
        ;;

    *)
        show_help
        ;;
esac
