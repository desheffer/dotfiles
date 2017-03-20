#==============================================================================
# Basics
#==============================================================================

# Add user binary path.
[ -d ~/bin ] && export PATH="$HOME/bin:$PATH"

# If not running interactively, don't do anything else.
[ -z "$PS1" ] && return

# Update window size.
shopt -s checkwinsize 2>/dev/null

# Enable glob star.
shopt -s globstar 2>/dev/null

# Enable auto cd.
shopt -s autocd 2>/dev/null

#==============================================================================
# Aliases
#==============================================================================

# Set text editor.
export EDITOR='vim'

# Custom aliases.
alias less='less -FXR'
alias la='ls -A'
alias ll='ls -Al'
alias tmux='tmux -2'
alias vi='vim'
alias vim='vim -p'
alias serve='python -m SimpleHTTPServer 8000'

# Linux specific setup.
if [ "$(uname -s)" == 'Linux' ]; then
    eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi

# Mac OS X specific setup.
if [ "$(uname -s)" == 'Darwin' ]; then
    alias ls='ls -G'
    alias vim='mvim -v -p'
fi

#==============================================================================
# Functions
#==============================================================================

# Quick grep command.
function g {
    vi "+Grepper -query '$@'"
}

function gg {
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
    echo 'Use `vi` with <C-t> instead!'
}

# Quick development directory change command.
function d {
    git rev-parse 2>/dev/null && cd "$(git rev-parse --show-cdup)"
}

function passwordgen {
    if [ $# -lt 1 ]; then
        LENGTH=32
    else
        LENGTH=$1
    fi

    LC_CTYPE=C tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c $LENGTH
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

#==============================================================================
# Prompt
#==============================================================================

function __git_status {
    STATUS=$(__git_ps1 '%s')

    [ -z "$STATUS" ] && return

    HEAD=$(echo "$STATUS" | cut -d'|' -f1 | cut -d' ' -f1)
    REBASE=$(echo "$STATUS" | cut -d '|' -s -f 2)

    local BRANCH=''
    local COMMIT=''
    local TAG=''

    if [[ "$HEAD" =~ ^\(.*\.\.\.\)$ ]]; then
        echo -en "${COMMIT} ${HEAD}"
    elif [[ "$HEAD" =~ ^\(.*\)$ ]]; then
        echo -en "${TAG} ${HEAD:1:-1}"
    else
        echo -en "${BRANCH} ${HEAD}"
    fi

    [ ! -z "$REBASE" ] && echo -en "  (${REBASE})"
}

function __generate_prompt {
    if [ -z "$PROMPT_COLOR" ]; then
        PROMPT_COLOR=10
    fi

    local SEP=''
    local RSEP=''

    local RESET=$(tput sgr0)

    local A_FG=$(tput setaf 0)
    local A_BG=$(tput setab $PROMPT_COLOR)
    local A_SEP_FG=$(tput setaf $PROMPT_COLOR)
    local B_FG=$(tput setaf 15)
    local B_BG=$(tput setab 237)
    local B_SEP_FG=$(tput setaf 237)
    local C_FG=$(tput setaf $PROMPT_COLOR)

    # Set window title.
    echo -en "\033]0;\u@\h:\w\a"

    # Generate powerline prompt.
    echo -en "\n"
    echo -en "${RESET}${A_BG}${A_FG}"
    echo -en "  \u@\h  "
    echo -en "${RESET}${B_BG}${A_SEP_FG}${SEP}${B_FG}"
    echo -en "  \w  "
    echo -en "${RESET}${B_SEP_FG}${SEP}${C_FG}"
    echo -en "  \$(__git_status)  "
    echo -en "${RESET}"
    echo -en "\n\$ "
}

function __set_prompt {
    PS1="$(__generate_prompt)"
    PROMPT_COMMAND=
}

# Provide fallback prompt.
PS1="\n\u@\h:\w\n\$ "

# Upgrade to a color prompt.
[[ "$TERM" =~ .*-256color ]] && PROMPT_COMMAND='__set_prompt'

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

# Git scripts.
[ -f ~/.git-completion.bash ] && . ~/.git-completion.bash
[ -f ~/.git-prompt.sh ] && . ~/.git-prompt.sh

#==============================================================================
# Miscellaneous
#==============================================================================

# Add RVM paths.
[ -f ~/.rvm/scripts/rvm ] && . ~/.rvm/scripts/rvm

# Add fzf paths.
[ -f ~/.fzf.bash ] && . ~/.fzf.bash

# Allow server-specific scripting.
[ -f ~/.bashrc.local ] && . ~/.bashrc.local
