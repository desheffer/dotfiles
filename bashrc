# Add user binary path.
[ -d "$HOME/bin" ] && export PATH="$PATH:$HOME/bin"

# If not running interactively, don't do anything else.
[ -z "$PS1" ] && return

# Update window size.
shopt -s checkwinsize

#==============================================================================
# Prompt
#==============================================================================

# Note: Colors can be approximated with the following equation:
#       6^2 * $R + 6 * $G + $B + 16
#       Where $R, $G, and $B are in the range (0, 5).

if [[ "$TERM" =~ .*-256color ]]; then
    icon_commit='➦'
    icon_branch=''
    icon_left_sep=''
    icon_left_alt_sep=''
    icon_right_sep=''
    icon_right_alt_sep=''
else
    icon_commit='c:'
    icon_branch='b:'
    icon_left_sep=''
    icon_left_alt_sep=''
    icon_right_sep=''
    icon_right_alt_sep=''
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
    color_reset
    color_set_fg "$1"
    color_set_bg "$2"

    block_current_fg="$1"
    block_current_bg="$2"
}

function block_change {
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
    color_reset
    color_set_fg "$1"
    color_set_bg "$block_current_bg"
    echo -en "$icon_left_alt_sep"
    color_reset
    color_set_fg "$block_current_fg"
    color_set_bg "$block_current_bg"
}

function block_end {
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
    if [ -z "$PROMPT_COLOR" ]; then
        PROMPT_COLOR=7
    fi

    # Window title.
    echo -en "\033]0;\u@\h:\w\a"

    # Basic prompt.
    echo
    block_start 0 $PROMPT_COLOR
    block_text "\u@\h"
    block_change 15 237
    block_text "\w"

    # Git info.
    if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
        ref=$(git symbolic-ref HEAD 2>/dev/null) || ref="$icon_commit $(git show-ref --head -s --abbrev | head -n1 2>/dev/null)"
        block_change $PROMPT_COLOR 0
        block_text ${ref/refs\/heads\//$icon_branch }
    fi

    block_end
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
alias less='less -FXR'
alias la='ls -A'
alias ll='ls -Al'
alias tmux='tmux -2'
alias vi='vim -p'
alias vim='vim -p'

# Quick grep command.
function g() {
    OPTS="-n"
    SEARCH="$@"
    if [[ $SEARCH =~ ^[^A-Z]*$ ]]; then
        OPTS="${OPTS}i"
    fi
    git grep "$OPTS" "$SEARCH"
}

# Quick find command.
function f() {
    SEARCH="$@"
    find -iname "*$SEARCH*" | less
}

# Quick development directory change command.
function d() {
    if [ -n "$1" ]; then
        cd "$HOME/$1"
    else
        git rev-parse 2>/dev/null
        if [ $? == 0 ]; then
            cd "$(git rev-parse --show-cdup)"
        else
            cd
        fi
    fi
}

# Remote copy.
function copyfrom() {
    ssh $1 "bash -c netpaste" | tee /dev/stderr | pbcopy
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

# Add RVM path.
[ -f "$HOME/.rvm/scripts/rvm" ] && . "$HOME/.rvm/scripts/rvm"
