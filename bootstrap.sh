#!/bin/bash

cd "$(dirname $0)"
HERE="$(pwd)"
FORCE="$(test "$1" == "-f" && echo true)"

# Remove broken links.
for FILE in ~/.*; do
    [ -L "${FILE}" ] && [ ! -e "${FILE}" ] && rm "${FILE}"
done

# Install new links.
for FILE in *; do
    # Skip excluded files.
    [ "${FILE}" == "$(basename $0)" ] && continue
    [[ "${FILE}" == README* ]] && continue

    SRC="${HERE}/${FILE}"
    DEST="${HOME}/.${FILE}"

    # Skip if no change is needed.
    if [ "$(readlink "${DEST}")" == "${SRC}" ]; then
        continue
    fi

    echo "Installing ${DEST}..."

    # Abort if the file already exists.
    if [ -e ${DEST} ] && [ ! ${FORCE} ]; then
        echo "Error: ${DEST} already exists!"
        exit 1
    fi

    # Link the new file into place.
    ln -snf "${SRC}" "${DEST}"
done

# Set up Git.
if [ ! -e ~/.git-completion.bash ]; then
    curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
fi

if [ ! -e ~/.git-prompt.sh ]; then
    curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o ~/.git-prompt.sh
fi

# Set up tmux.
if [ ! -e ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

~/.tmux/plugins/tpm/bin/install_plugins

mkdir -p ~/.vim/swap
mkdir -p ~/.vim/backup
mkdir -p ~/.vim/undo

# Set up Vim.
if [ ! -f ~/.vim/autoload/plug.vim ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

vim +PlugUpdate +qall
