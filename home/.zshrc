setopt AUTO_CD                  # If command is a directory, cd to it.
setopt AUTO_PUSHD               # Make cd push to the directory stack.
setopt PUSHD_SILENT             # Do not print the directory stack.

setopt ALWAYS_TO_END            # If completing in a word, move to end of word.
setopt COMPLETE_IN_WORD         # Allow tab completion in the middle of a word.

setopt APPEND_HISTORY           # Append history, do not replace it.
setopt EXTENDED_HISTORY         # Save timestamps in the history file.
setopt HIST_FIND_NO_DUPS        # Ignore duplicates when searching.
setopt HIST_IGNORE_DUPS         # Ignore duplicates of the previous command.
setopt HIST_VERIFY              # Allow editing for history expansion.
setopt INC_APPEND_HISTORY       # Append history immediately.

setopt INTERACTIVE_COMMENTS     # Allow comments in interactive shells.

setopt PROMPT_SUBST             # Perform substitutions in prompts.

unsetopt BEEP                   # Do not beep.

# Configure history.
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Enable directory colors.
eval "$(dircolors)"

# Enable completion.
autoload -Uz compinit
compinit

# Enable completion menu.
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:commands' rehash 1
zstyle ':completion:*:*:*:*:*' menu select

# Enable emacs mode.
bindkey -e

# But allow escape to vi mode.
bindkey '^[' vi-cmd-mode
export KEYTIMEOUT=1

# Bind home, end, and del keys.
bindkey '^[[H' beginning-of-line
bindkey '^[[1~' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[4~' end-of-line
bindkey '^[[3~' delete-char

# Use Neovim.
export EDITOR='nvim'

# Enable fzf.
[ -f /usr/share/fzf/key-bindings.zsh ] && . /usr/share/fzf/key-bindings.zsh

# Add various paths.
[ -f ~/.zshrc.functions ] && . ~/.zshrc.functions
[ -f ~/.zshrc.local ] && . ~/.zshrc.local

# Initialize Starship.
eval "$(starship init zsh)"