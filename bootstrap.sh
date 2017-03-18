#!/bin/bash

cd "$(dirname $0)"
HERE="$(pwd)"

for FILE in *; do

    # Excluded files, continue.
    [ "$FILE" == "$(basename $0)" ] && continue
    [[ "$FILE" == README* ]] && continue

    SRC="$HERE/$FILE"
    DEST="$HOME/.$FILE"

    # No change, continue.
    if [ "$(readlink "$DEST")" == "$SRC" ]; then
        continue
    fi

    # Abort if the file already exists.
    if [ -e "$DEST" ]; then
        echo "Error: $DEST already exists!"
        exit 0
    fi

    # Link the new file into place.
    echo "Installing $DEST..."
    rm -f "$DEST" && ln -s "$SRC" "$DEST"

done

if [ ! -e ~/.git-completion.bash ]; then
    curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
fi

if [ ! -e ~/.git-prompt.sh ]; then
    curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o ~/.git-prompt.sh
fi

mkdir -p ~/.vim/swap
mkdir -p ~/.vim/backup
mkdir -p ~/.vim/undo

# Install Vim plugins.
if [ ! -f ~/.vim/autoload/plug.vim ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
vim +PlugUpdate +qall
