#==============================================================================
# Basics
#==============================================================================

# Add ~/bin path.
[ -d ~/bin ] && export PATH="$HOME/bin:$PATH"

# If not running interactively, don't do anything else.
[ -z "$PS1" ] && return

# Update window size.
shopt -s checkwinsize 2>/dev/null

# Enable glob star.
shopt -s globstar 2>/dev/null

# Enable auto cd.
shopt -s autocd 2>/dev/null

# Use Vim.
export EDITOR='vim'

# Use sane defaults for less.
export LESS="-FXR $LESS"

#==============================================================================
# Aliases
#==============================================================================

# Set up custom aliases.
alias la='ls -A'
alias ll='ls -Al'
alias tmux='tmux -2'
alias vi='vim'
alias vim='vim -p'
alias serve='python -m SimpleHTTPServer 8000'
alias unquarantine='sudo xattr -r -d com.apple.quarantine'

# Run specific commands for Linux.
if [ "$(uname -s)" == 'Linux' ]; then
    eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi

# Run specific commands for OS X.
if [ "$(uname -s)" == 'Darwin' ]; then
    alias ls='ls -G'
    alias vim='mvim -v -p'
fi

#==============================================================================
# Functions
#==============================================================================

# Quickly search for and open a file.
function g {
    [ -z "$*" ] && return
    TMP=$(mktemp)
    ag "$*" | fzf -m > $TMP
    [ -s $TMP ] && vim -q $TMP +copen
    cat $TMP | sed 's/:[0-9]*:.*$//'
    rm $TMP
}

# Quickly change to the root directory of a repository.
function d {
    git rev-parse 2>/dev/null && cd "$(git rev-parse --show-cdup)"
}

# Generate a secure password.
function passwordgen {
    if [ $# -lt 1 ]; then
        LENGTH=32
    else
        LENGTH=$1
    fi

    LC_CTYPE=C tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c $LENGTH
    echo
}

# Generate ctags for a PHP project.
function phptags {
    rm -f tags
    find . -type f -iname "*.php" -not -path "/vendor" | xargs ctags -a
}

# Safely reset a Git repository to match a remote branch.
function git-reset {
    git rev-parse 2>/dev/null || return

    TIMESTAMP=$(date '+%Y%m%d%H%M%S')
    OLD_BRANCH="$(git rev-parse --symbolic-full-name --abbrev-ref HEAD)"
    NEW_BRANCH="$1"

    if [ -z "$NEW_BRANCH" ]; then
        NEW_BRANCH="$OLD_BRANCH"
    fi

    cd "$(git rev-parse --show-cdup)"
    git add .
    git commit -m "auto commit at $TIMESTAMP" >/dev/null
    if [ $? -eq 0 ]; then
        echo "Creating backup: $OLD_BRANCH-$TIMESTAMP"
        git branch "$OLD_BRANCH-$TIMESTAMP"
    fi

    git checkout "$NEW_BRANCH" >/dev/null 2>/dev/null
    git fetch origin >/dev/null
    git reset --hard "origin/$NEW_BRANCH"
}

# Open an SSH connection with tmux.
function ssh-tmux {
    ssh "$1" -t "tmux -2u attach 2>/dev/null || tmux -2u new-session"
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

    if [ -z "$PROMPT_USER" ]; then
        PROMPT_USER='\u@\h'
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
    echo -en "  ${PROMPT_USER}  "
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

# Provide a fallback prompt.
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

# Source Git helper scripts.
[ -f ~/.git-completion.bash ] && . ~/.git-completion.bash
[ -f ~/.git-prompt.sh ] && . ~/.git-prompt.sh

#==============================================================================
# Docker
#==============================================================================

alias dkr-nginx-proxy='docker stop proxy && docker rm proxy; docker pull jwilder/nginx-proxy && docker run --name proxy -d -p 80:80 -p 443:443 -v /var/run/docker.sock:/tmp/docker.sock:ro -v ~/.rs/.nginx-html:/usr/share/nginx/html:rw -v ~/.rs/.nginx-proxy.conf:/etc/nginx/conf.d/proxy.conf:ro -v ~/.rs/.nginx-certs:/etc/nginx/certs:ro -v ~/.rs/.nginx-vhost.d/:/etc/nginx/vhost.d:rw --log-opt max-size=1M --net bridge --label com.github.jrcs.letsencrypt_nginx_proxy_companion.nginx_proxy=true jwilder/nginx-proxy'
alias dkr-ssl='docker stop ssl && docker rm ssl; docker pull jrcs/letsencrypt-nginx-proxy-companion && docker run --name ssl -d -v /var/run/docker.sock:/var/run/docker.sock:ro -v ~/.rs/.nginx-certs:/etc/nginx/certs:rw --volumes-from proxy jrcs/letsencrypt-nginx-proxy-companion'
alias dkr-proxy='dkr-nginx-proxy && dkr-ssl'

#==============================================================================
# Miscellaneous
#==============================================================================

# Add RVM paths.
[ -f ~/.rvm/scripts/rvm ] && . ~/.rvm/scripts/rvm

# Add fzf paths.
[ -f ~/.fzf.bash ] && . ~/.fzf.bash

# Allow server-specific scripting.
[ -f ~/.bashrc.local ] && . ~/.bashrc.local
