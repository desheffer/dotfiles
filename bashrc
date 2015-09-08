# Add user binary path.
[ -d "$HOME/bin" ] && export PATH="$PATH:$HOME/bin"

# If not running interactively, don't do anything else.
[ -z "$PS1" ] && return

# Update window size.
shopt -s checkwinsize

# Enable vi mode.
set -o vi

#==============================================================================
# Prompt
#==============================================================================

# Note: Colors can be approximated with the following equation:
#       6^2 * $R + 6 * $G + $B + 16
#       Where $R, $G, and $B are in the range (0, 5).

if [[ "$TERM" =~ .*-256color ]]; then
    prompt_colors=1
    icon_commit='➦'
    icon_branch=''
    icon_left_sep=''
    icon_left_alt_sep=''
    icon_right_sep=''
    icon_right_alt_sep=''
else
    prompt_colors=
    icon_commit='c:'
    icon_branch='b:'
fi

function color_set_fg {
    echo -en "\033[1;38;5;${1}m"
}

function color_set_bg {
    echo -en "\033[48;5;${1}m"
}

function color_reset {
    echo -en "\033[0m"
}

function block_start {
    if [ -z "$prompt_colors" ]; then
        return
    fi

    color_reset
    color_set_fg "$1"
    color_set_bg "$2"

    block_current_fg="$1"
    block_current_bg="$2"
}

function block_change {
    if [ -z "$prompt_colors" ]; then
        return
    fi

    color_reset
    color_set_fg "$block_current_bg"
    color_set_bg "$2"
    echo -en "$icon_left_sep"
    color_reset
    color_set_fg "$1"
    color_set_bg "$2"

    block_current_fg="$1"
    block_current_bg="$2"
}

function block_sep {
    if [ -z "$prompt_colors" ]; then
        echo -en " > "
        return
    fi

    color_reset
    color_set_fg "$1"
    color_set_bg "$block_current_bg"
    echo -en "$icon_left_alt_sep"
    color_reset
    color_set_fg "$block_current_fg"
    color_set_bg "$block_current_bg"
}

function block_end {
    if [ -z "$prompt_colors" ]; then
        return
    fi

    color_reset
    color_set_fg "$block_current_bg"
    echo -en "$icon_left_sep"
    color_reset

    block_current_fg=
    block_current_bg=
}

function block_text {
    echo -en "  $@  "
}

function generate_prompt {
    EXIT_CODE=$?

    if [ -z "$PROMPT_COLOR" ]; then
        PROMPT_COLOR=7
    fi

    # Window title.
    [ $prompt_color ] && echo -en "\033]0;\u@\h:\w\a"

    # Basic prompt.
    echo
    block_start 0 $PROMPT_COLOR
    block_text "\u@\h"
    block_change 15 237
    block_text "\w"
    block_end

    # Git info.
    if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
        ref=$(git symbolic-ref HEAD 2>/dev/null) || ref="$icon_commit $(git show-ref --head -s --abbrev | head -n1 2>/dev/null)"
        [ $prompt_colors ] && color_set_fg $PROMPT_COLOR
        echo -en "  ${ref/refs\/heads\//$icon_branch }"
        [ $prompt_colors ] && color_reset
    fi

    if [ $EXIT_CODE != 0 ]; then
        [ $prompt_colors ] && color_set_fg 1
        block_text "${EXIT_CODE##0}"
        [ $prompt_colors ] && color_reset
    fi

    echo -en "\n\$ "
}

function set_prompt {
    PS1="$(generate_prompt)"
}

PROMPT_COMMAND='set_prompt'

#==============================================================================
# Aliases
#==============================================================================

# Custom aliases.
alias ..='cd ..'
alias less='less -FXR'
alias la='ls -A'
alias ll='ls -Al'
alias tmux='tmux -2'
alias vi='vim -p'
alias vim='vim -p'
alias serve='python -m SimpleHTTPServer 8000'

# Quick grep command.
function g {
    SEARCH="$@"

    OPTS="-n"
    if [[ $SEARCH =~ ^[^A-Z]*$ ]]; then
        OPTS="${OPTS} -i"
    fi

    git grep $OPTS "$SEARCH" \
        -- './*' ':!*.min.css' ':!*.min.js' ':!/public/static/generated/' ':!/public/dist/' \
        | sed -nr 's/^([^:]*):([0-9]*):/\1 : \2 ::\t/p' \
        | less
}

# Quick find command.
function f {
    SEARCH="$@"
    find -iname "*$SEARCH*" | less
}

# Quick development directory change command.
function d {
    git rev-parse 2>/dev/null && cd "$(git rev-parse --show-cdup)"
}

function passwordgen {
    if [ $# -lt 1 ]; then
        length=16
    else
        length=$1
    fi

    cat /dev/urandom | LC_CTYPE=C tr -dc 'a-zA-Z0-9' | head -c $length
    echo
}

# Remote copy.
function copyfrom {
    ssh $1 "bash -c netpaste" | tee /dev/stderr | pbcopy
}

# Generate ctags for a PHP project.
function phptags {
    rm -f tags
    find . -type f -iname "*.php" -not -path "/vendor" | xargs ctags -a
}

# Linux specific setup.
if [ $(uname) == 'Linux' ]; then
    eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi

# Mac OS X specific setup.
if [ $(uname) == 'Darwin' ]; then
    alias ls='ls -G'
    alias vim='mvim -v'
fi

#==============================================================================
# SSH
#==============================================================================

# Setup SSH agent.
if [ -n "$SSH_TTY" ]; then
    SSH_ENV=~/.ssh/environment

    function start_agent {
        echo "Initializing new SSH agent..."
        /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
        chmod 600 "${SSH_ENV}"
        . "${SSH_ENV}" > /dev/null
        ssh-add
    }

    # Source SSH settings, if applicable.
    if [ -f "${SSH_ENV}" ]; then
        . "${SSH_ENV}" > /dev/null
        ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
            start_agent
        }
    else
        start_agent
    fi
fi

#==============================================================================
# Git
#==============================================================================

# Git paging.
export GIT_PAGER='less -+$LESS -FXR'

# Git auto completion.
if [ -n "$BASH_VERSION" ]; then
    . ~/.git-completion.bash
fi

#==============================================================================
# Custom Paths
#==============================================================================

# Allow server-specific scripting.
[ -f "$HOME/.bash_local" ] && . "$HOME/.bash_local"
