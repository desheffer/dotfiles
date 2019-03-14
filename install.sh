#!/bin/bash

set -e

cd "$(dirname "$0")"

function link_file {
    # Skip if no change is needed.
    if [ "$(readlink "$2")" == "$1" ]; then
        return 0
    fi

    echo "Linking $2..."

    # Abort if the file already exists.
    if [ ! "${FORCE}" ] && [ -e "$2" ]; then
        echo "Error: $2 already exists!"
        return 1
    fi

    # Link the new file into place.
    mkdir -p "$(dirname "$2")"
    ln -snf "$1" "$2"
}

[ "$1" == "-f" ] && FORCE="1"

# Link files into place.
link_file "$(pwd)/home/.bash_logout" "${HOME}/.bash_logout"
link_file "$(pwd)/home/.bash_profile" "${HOME}/.bash_profile"
link_file "$(pwd)/home/.bashrc" "${HOME}/.bashrc"
link_file "$(pwd)/home/.bashrc.functions" "${HOME}/.bashrc.functions"
link_file "$(pwd)/home/.bashrc.theme" "${HOME}/.bashrc.theme"
link_file "$(pwd)/home/.conkyrc" "${HOME}/.conkyrc"
link_file "$(pwd)/home/.conkyrc.weather" "${HOME}/.conkyrc.weather"
link_file "$(pwd)/home/.gitconfig" "${HOME}/.gitconfig"
link_file "$(pwd)/home/.profile" "${HOME}/.profile"
link_file "$(pwd)/home/.tmux.conf" "${HOME}/.tmux.conf"
link_file "$(pwd)/home/.tmux.theme" "${HOME}/.tmux.theme"
link_file "$(pwd)/home/.vimrc" "${HOME}/.vimrc"

mkdir -p "${HOME}/.gnupg"
link_file "$(pwd)/home/.gnupg/gpg.conf" "${HOME}/.gnupg/gpg.conf"

# Set up tmux.
if [ ! -e ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

~/.tmux/plugins/tpm/bin/install_plugins

# Set up Vim.
mkdir -p ~/.vim/swap
mkdir -p ~/.vim/backup
mkdir -p ~/.vim/undo

if [ ! -f ~/.vim/autoload/plug.vim ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

vim +PlugUpdate +qall
