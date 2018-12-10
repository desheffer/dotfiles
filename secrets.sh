#!/bin/env bash

set -euo pipefail

readonly prefix="Dotfiles/"

if [ -t 1 ]; then
    readonly success=$(tput setaf 2)$(tput bold)
    readonly info=$(tput setaf 4)
    readonly reset=$(tput sgr0)
else
    readonly success=
    readonly info=
    readonly reset=
fi

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

function get_keys {
    lpass ls "${prefix}" | sed -n "s|^${prefix}\(.\+\) \[.*\]|\1|p"
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
    get_keys | while read line; do
        echo "${success}${line}${reset}"
    done
}

function do_get {
    key="${1}"
    path=$(key_to_path "${key}")

    if [ -e "${path}" ]; then
        echo "${info}Skipped '${path}' <- '${key}'${reset}"
        return
    fi

    mkdir -p "$(dirname "${path}")"
    lpass show --notes "${prefix}${key}" >"${path}"
    chmod 0600 "${path}"

    echo "${success}Downloaded '${path}' <- '${key}'${reset}"
}

function do_put {
    path="${1}"
    key=$(path_to_key "${path}")

    lpass edit --non-interactive --notes "${prefix}${key}" <"${path}"

    echo "${success}Uploaded '${path}' -> '${key}'${reset}"
}

function do_rm {
    key="${1}"

    lpass rm "${prefix}${key}"

    echo "${success}Removed '${key}'${reset}"
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
        for key in $(get_keys); do
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
            if [ -z "$(get_keys | grep -Fx "${key}")" ]; then
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
