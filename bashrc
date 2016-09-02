# Add user binary path.
[ -d "$HOME/bin" ] && export PATH="$PATH:$HOME/bin"

# If not running interactively, don't do anything else.
[ -z "$PS1" ] && return

# Update window size.
shopt -s checkwinsize 2>/dev/null

# Enable glob star.
shopt -s globstar 2>/dev/null

# Enable auto cd.
shopt -s autocd 2>/dev/null

#==============================================================================
# Prompt
#==============================================================================

[[ "$TERM" =~ .*-256color ]] && . "$HOME/.bash_prompt"

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
alias serve='python -m SimpleHTTPServer 8000'

# Path replacement.
function cd {
    if [ $# -eq 2 ]; then
        builtin cd ${PWD/$1/$2}
    else
        builtin cd $1
    fi
}

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
[ -n "$BASH_VERSION" ] && . "$HOME/.git-completion.bash"

#==============================================================================
# Miscellaneous
#==============================================================================

# Add RVM paths.
[ -f "$HOME/.rvm/scripts/rvm" ] && . "$HOME/.rvm/scripts/rvm"

# Allow server-specific scripting.
[ -f "$HOME/.bash_local" ] && . "$HOME/.bash_local"
