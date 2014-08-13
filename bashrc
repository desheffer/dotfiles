# If not running interactively, don't do anything.
[ -z "$PS1" ] && return

# Update window size.
shopt -s checkwinsize

#
# PROMPT
#

if [[ "$TERM" =~ .*-256color ]]; then
    icon_commit='➦'
    icon_branch='⭠'
    icon_separator='⮀'
else
    icon_commit='c:'
    icon_branch='b:'
    icon_separator=''
fi

function color_set_fg {
    code=16
    [ $# -ge 3 ] && code=$((16 + $1 * 6 * 6 + $2 * 6 + $3))
    echo -en "\033[1;38;5;${code}m"
}

function color_set_bg {
    code=16
    [ $# -ge 3 ] && code=$((16 + $1 * 6 * 6 + $2 * 6 + $3))
    echo -en "\033[48;5;${code}m"
    color_current_bg="$1 $2 $3"
}

function color_reset {
    echo -en "\033[0m"
}

function color_start {
    color_reset
    echo
    color_set_fg $1 $2 $3
    color_set_bg $4 $5 $6
}

function color_change {
    color_reset
    color_set_fg $color_current_bg
    [ $# -ge 3 ] && color_set_bg $4 $5 $6
    echo -en "$icon_separator"
    [ $# -ge 3 ] && color_set_fg $1 $2 $3
}

function color_end {
    color_change
    color_reset
}

function color_block {
    echo -en "  $@  "
}

function generate_prompt {
    # Window title.
    echo -en "\033]0;\u@\h:\w\a"

    # Basic prompt.
    color_start 0 0 0 5 4 0
    color_block "\u@\h"
    color_change 5 5 5 1 1 1
    color_block "\w"

    # Git info.
    if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
        ref=$(git symbolic-ref HEAD 2>/dev/null) || ref="$icon_commit $(git show-ref --head -s --abbrev | head -n1 2>/dev/null)"
        color_change 0 3 5
        color_block ${ref/refs\/heads\//$icon_branch }
    fi

    color_end
    echo -en "\n\$ "
}

function set_prompt {
    PS1="$(generate_prompt)"
}

PROMPT_COMMAND='set_prompt'

#
# ALIASES
#

# Custom aliases.
alias less='less -FXR'
alias la='ls -A'
alias ll='ls -Al'
alias tmux='tmux -2'
alias vi='vim -p'

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

# Listen for remote copy notifications.
function remote-copy-server() {
    while (true); do nc -l 48824 | pbcopy; done
}

# Send a remote copy notification.
function remote-copy() {
    cat | nc localhost 48824
}

# Set up Ansible.
function deploy() {
    eval `ssh-agent` && ssh-add -K && ssh-add ~/.ssh/*.pem
    source /usr/share/ansible/hacking/env-setup
    cd /etc/ansible
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

# Add user binary path.
[ -d "$HOME/bin" ] && export PATH="$PATH:$HOME/bin"

# Add RVM path.
[ -f "$HOME/.rvm/scripts/rvm" ] && . "$HOME/.rvm/scripts/rvm"

# Allow server-specific scripting.
[ -f "$HOME/.bash_custom" ] && . "$HOME/.bash_custom"
