#!/bin/bash

cd "$(dirname $0)"
HERE="$(pwd)"

STASH="$HERE/.stash/$(date +%s)"
REVERT="$STASH/revert"

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

    echo "Installing $DEST..."

    # Move any existing files into the stash.
    if [ -e "$DEST" ]; then
        mkdir -p "$STASH"

        STASHFILE="$STASH/.$FILE"
        mv "$DEST" "$STASHFILE"
        echo "Stashed existing file as $STASHFILE"

        # Log the steps necessary to revert changes.
        echo "# Revert .$FILE" >> "$REVERT"
        echo "rm -f '$DEST'" >> "$REVERT"
        echo "cp '$STASHFILE' '$DEST'" >> "$REVERT"
        echo >> "$REVERT"
    fi

    # Link the new file into place.
    rm -f "$DEST" && ln -s "$SRC" "$DEST"

done

# Notify the user about the revert script.
if [ -e "$REVERT" ]; then
    echo "Revert log stored as $REVERT"
fi

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
