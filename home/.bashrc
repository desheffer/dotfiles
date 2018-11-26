#==============================================================================
# Environment Settings
#==============================================================================

# Add ~/bin path.
[ -d ~/bin ] && export PATH="${HOME}/bin:${PATH}"

# If not running interactively, don't do anything else.
[ -z "${PS1}" ] && return

# Update window size.
shopt -s checkwinsize 2>/dev/null

# Enable glob star.
shopt -s globstar 2>/dev/null

# Enable auto cd.
shopt -s autocd 2>/dev/null

# Use Vim.
export EDITOR='vim'

# Use sane defaults for less.
export LESS="-FXR ${LESS}"

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
alias traefik="docker stop traefik && docker rm traefik; docker pull traefik && docker run --name traefik -d -p 8080:8080 -p 80:80 -p 443:443 -v /var/run/docker.sock:/var/run/docker.sock traefik --api --defaultentrypoints=https --docker --docker.domain=local.sqr.io --entrypoints='Name:https Address::443 TLS'"
alias vi='vim'
alias vim='vim -p'

#==============================================================================
# Functions
#==============================================================================

# Quickly search for and open a file.
function g {
    [ -z "$*" ] && return
    tmp=$(mktemp)
    ag "$*" | fzf -m > ${tmp}
    [ -s ${tmp} ] && vim -q ${tmp} +copen
    cat ${tmp} | sed 's/:[0-9]*:.*$//'
    rm ${tmp}
}

# Quickly search for and open all matches.
function ga {
    [ -z "$*" ] && return
    tmp=$(mktemp)
    ag "$*" > ${tmp}
    [ -s ${tmp} ] && vim -q ${tmp} +copen
    cat ${tmp} | sed 's/:[0-9]*:.*$//'
    rm ${tmp}
}

# Quickly change to the root directory of a repository.
function d {
    git rev-parse 2>/dev/null && cd "$(git rev-parse --show-cdup)"
}

# Generate a secure password.
function passwordgen {
    if [ $# -lt 1 ]; then
        length=32
    else
        length="${1}"
    fi

    LC_CTYPE=C tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c "${length}"
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

    timestamp="$(date '+%Y%m%d%H%M%S')"
    oldBranch="$(git rev-parse --symbolic-full-name --abbrev-ref HEAD)"
    newBranch="$1"

    if [ -z "${newBranch}" ]; then
        newBranch="${oldBranch}"
    fi

    cd "$(git rev-parse --show-cdup)"
    git add .
    git commit -m "auto commit at ${timestamp}" >/dev/null
    if [ $? -eq 0 ]; then
        echo "Creating backup: ${oldBranch}-${timestamp}"
        git branch "${oldBranch}-${timestamp}"
    fi

    git checkout "${newBranch}" >/dev/null 2>/dev/null
    git fetch origin >/dev/null
    git reset --hard "origin/${newBranch}"
}

# Open an SSH connection with tmux.
function ssh-tmux {
    ssh "${1}" -t "tmux -2u attach 2>/dev/null || tmux -2u new-session"
}

# Convert GitHub HTTPS URL to SSH.
function github-https-to-ssh {
    sshUrl="$(git remote get-url origin | sed 's|https://github.com/\(.*\)|git@github.com:\1|')"
    git remote set-url origin "${sshUrl}"
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

# Add various paths.
[ -f ~/.cargo/env ] && . ~/.cargo/env
[ -f ~/.fzf.bash ] && . ~/.fzf.bash
[ -f ~/.rvm/scripts/rvm ] && . ~/.rvm/scripts/rvm

# Add local overrides.
[ -f ~/.bashrc.local ] && . ~/.bashrc.local
