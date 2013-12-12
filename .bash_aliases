alias vi='vim -p'
alias tmux='tmux -2'

# Quick file grep command.
function g() {
    opts="-nrs"
    search="$@"
    if [[ $search =~ ^[^A-Z]*$ ]]; then
        opts=${opts}i
    fi
    grep $opts --exclude-dir=.git "$search" .;
}
