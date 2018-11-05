#==============================================================================
# Environment Settings
#==============================================================================

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

# Enable directory colors.
eval "$(dircolors -b)"

#==============================================================================
# Aliases
#==============================================================================

# Set up custom aliases.
alias :qa='exit'
alias bob='ag -l | entr make'
alias dkr-sh='docker run -it --rm --entrypoint sh'
alias gca='git commit --amend'
alias gcm='git commit -m'
alias gs='git status'
alias la='ls -A'
alias ll='ls -Al'
alias ls='ls --color=auto'
alias serve='python3 -m http.server 8000'
alias ta='tmux -2u attach 2>/dev/null || tmux -2u new-session'
alias tmux='tmux -2'
alias traefik='docker stop traefik && docker rm traefik; docker pull traefik && docker run --name traefik -d -p 8080:8080 -p 80:80 -v /var/run/docker.sock:/var/run/docker.sock traefik --api --docker'
alias vi='vim'
alias vim='vim -p'

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

# Quickly search for and open all matches.
function ga {
    [ -z "$*" ] && return
    TMP=$(mktemp)
    ag "$*" > $TMP
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
# External Scripts
#==============================================================================

# Set prompt.
[ -f ~/.bashrc.theme ] && . ~/.bashrc.theme

# Add bash completion.
[ -f /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Source Git helper script.
[ -f /usr/share/git/git-prompt.sh ] && . /usr/share/git/git-prompt.sh
[ -f /usr/share/git-core/contrib/completion/git-prompt.sh ] && . /usr/share/git-core/contrib/completion/git-prompt.sh

# Add ~/bin path.
[ -d ~/bin ] && export PATH="$HOME/bin:$PATH"

# Add various paths.
[ -f ~/.cargo/env ] && . ~/.cargo/env
[ -f ~/.fzf.bash ] && . ~/.fzf.bash
[ -f ~/.rvm/scripts/rvm ] && . ~/.rvm/scripts/rvm

# Add local overrides.
[ -f ~/.bashrc.local ] && . ~/.bashrc.local
