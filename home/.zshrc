# Enable auto change directory.
setopt AUTO_CD

# Allow tab completion in the middle of a word.
setopt COMPLETE_IN_WORD

# Never beep.
setopt NO_BEEP

# Autocomplete like Bash.
setopt NO_AUTO_MENU

# Don't save duplicate history entries.
setopt HIST_IGNORE_ALL_DUPS

# Share history across sessions.
setopt SHARE_HISTORY

# Configure history.
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Enable completion.
autoload -Uz compinit
compinit

# Bind home, end, and del keys.
bindkey "^[[H" beginning-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[4~" end-of-line
bindkey "^[[3~" delete-char

# Enable fzf.
[ -f ~/.fzf.zsh ] && . ~/.fzf.zsh

# Add various paths.
[ -f ~/.zshrc.functions ] && . ~/.zshrc.functions
[ -f ~/.zshrc.local ] && . ~/.zshrc.local

# Initialize Starship.
eval "$(starship init zsh)"
