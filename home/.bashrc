# Add ~/bin path.
[ -d ~/bin ] && export PATH="${HOME}/bin:${PATH}"

# Stop if not running interactively.
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

# Add bash completion.
[ -f /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Add Git prompt.
[ -f /usr/share/git/git-prompt.sh ] && . /usr/share/git/git-prompt.sh
[ -f /usr/share/git-core/contrib/completion/git-prompt.sh ] && . /usr/share/git-core/contrib/completion/git-prompt.sh

# Add various paths.
[ -f ~/.cargo/env ] && . ~/.cargo/env
[ -f ~/.fzf.bash ] && . ~/.fzf.bash
[ -f ~/.rvm/scripts/rvm ] && . ~/.rvm/scripts/rvm

[ -f ~/.bashrc.functions ] && . ~/.bashrc.functions
[ -f ~/.bashrc.theme ] && . ~/.bashrc.theme
[ -f ~/.bashrc.local ] && . ~/.bashrc.local
