# If not running interactively, don't do anything.
[ -z "$PS1" ] && return

# Update window size.
shopt -s checkwinsize

#
# PROMPT
#

# Terminal colors.
function color {
    # Attributes r, g, b, in range [0, 5]
    if [ $# -ge 4 ]; then
        # Set foreground.
        code=$((16 + $2 * 6 * 6 + $3 * 6 + $4))
        echo -en "\033[1;38;5;${code}m"

        if [ $# -ge 7 ]; then
            # Set background.
            code=$((16 + $5 * 6 * 6 + $6 * 6 + $7))
            echo -en "\033[48;5;${code}m"
        fi
    fi

    # Output.
    echo -en "$1"

    # Reset.
    echo -en "\033[0m"
}

# Display prompt.
function display_prompt {
    sep='⮀'
    u="$USER"
    h="$HOSTNAME"
    w="${PWD/$HOME/~}"

    # Window title.
    echo -e "\033]0;$u@$h:$w\a"

    # Basic prompt.
    color "  $u@$h  " 0 0 0 5 4 0
    color "$sep" 5 4 0 1 1 1
    color "  $w  " 5 5 5 1 1 1
    color "$sep" 1 1 1

    # Git info.
    if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
        ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git show-ref --head -s --abbrev | head -n1 2> /dev/null)"
        color "  ${ref/refs\/heads\//⭠ }  " 1 4 5
    fi
}

# Setup shell prompt.
export PROMPT_COMMAND='display_prompt'
export PS1="\n$ "

#
# ALIASES
#

# Custom aliases.
alias less='less -FXR'
alias la='ls -A'
alias ll='ls -Al'
alias tmux='tmux -2'
alias vi='vim -p'

# Quick file grep command.
function g() {
    OPTS="-nrs"
    SEARCH="$@"
    if [[ $SEARCH =~ ^[^A-Z]*$ ]]; then
        OPTS="${OPTS}i"
    fi
    grep "$OPTS" --exclude-dir=.git "$SEARCH" . | less
}

# Quick find command.
function f() {
    SEARCH="$@"
    find -iname "*$SEARCH*" | less
}

# Quick development directory change command.
function d() {
    if [ -n "$1" ]; then
        cd "$HOME/$(whoami).$1"
    else
        (cd && ls -d "$(whoami)."*) | sed "s/$(whoami)\.//"
    fi
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

#
# SSH
#

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

#
# GIT
#

# Git paging.
export GIT_PAGER='less -+$LESS -FXR'

# Git auto completion.
if [ -n "$BASH_VERSION" ]; then
    . ~/.git-completion.bash
fi

#
# PATHS
#

# Add RVM to path.
[ -f "$HOME/.rvm/scripts/rvm" ] && . "$HOME/.rvm/scripts/rvm"

# Add custom paths.
[ -d "$HOME/bin" ] && export PATH="$PATH:$HOME/bin"
