# If not running interactively, don't do anything.
[ -z "$PS1" ] && return

# Update window size.
shopt -s checkwinsize

# Grab the current Git branch.
function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Build shell prompt.
WINDOW_TITLE='\[\e]0;\u@\h: \w\a\]'
PROMPT_BASIC='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]'
PROMPT_GIT=' \[\033[00;33m\]$(parse_git_branch)\[\033[00m\]'
export PS1="${WINDOW_TITLE}\n${PROMPT_BASIC}${PROMPT_GIT}\n\$ "

# Git auto completion.
if [ -n "$BASH_VERSION" ]; then
    . ~/.git-completion.bash
fi

# Git paging.
export GIT_PAGER='less -+$LESS -FRX'

# Custom aliases.
alias vi='vim -p'
alias tmux='tmux -2'

# Quick file grep command.
function g() {
    OPTS="-nrs"
    SEARCH="$@"
    if [[ $SEARCH =~ ^[^A-Z]*$ ]]; then
        OPTS="${OPTS}i"
    fi
    grep "$OPTS" --exclude-dir=.git "$SEARCH" .
}

# Quick find command.
function f() {
    SEARCH="$@"
    find -iname "*$SEARCH*"
}

# Linux specific setup.
if [ $(uname) == "Linux" ]; then
    eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi

# Mac OS X specific setup.
if [ $(uname) == "Darwin" ]; then
    alias ls='ls -G'
    alias vim='mvim -v'
fi

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

# Add RVM to path.
[ -f "$HOME/.rvm/scripts/rvm" ] && source "$HOME/.rvm/scripts/rvm"
