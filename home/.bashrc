# Stop if not running interactively.
[ -z "${PS1}" ] && return

# Update window size.
shopt -s checkwinsize 2>/dev/null

# Enable glob star.
shopt -s globstar 2>/dev/null

# Enable auto change directory.
shopt -s autocd 2>/dev/null

# Configure history.
HISTSIZE=-1
HISTFILESIZE=-1

# Use Vim.
export EDITOR="vim"

# Use sane defaults for less.
export LESS="-FXR ${LESS}"

# Enable directory colors.
eval "$(dircolors -b)"

# Enable completion.
[ -f /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Enable fzf.
[ -f ~/.fzf.bash ] && . ~/.fzf.bash

# Add various paths.
[ -f ~/.bashrc.functions ] && . ~/.bashrc.functions
[ -f ~/.bashrc.local ] && . ~/.bashrc.local

# Initialize Starship.
eval "$(starship init bash)"
