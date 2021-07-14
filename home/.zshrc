# Enable auto change directory.
setopt AUTOCD

# Autocomplete like Bash.
setopt NOAUTOMENU

# Don't save duplicate history entries.
setopt HISTIGNOREALLDUPS

# Share history across sessions.
setopt SHAREHISTORY

# Configure history.
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Enable completion.
autoload -Uz compinit
compinit

# Bind home and end keys.
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

# Enable fzf.
[ -f ~/.fzf.zsh ] && . ~/.fzf.zsh

# Add various paths.
[ -f ~/.zshrc.functions ] && . ~/.zshrc.functions
[ -f ~/.zshrc.local ] && . ~/.zshrc.local

# Initialize Starship.
eval "$(starship init zsh)"
