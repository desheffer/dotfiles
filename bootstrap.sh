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

# Install Vim plugins
mkdir -p ~/.backup
[ ! -d ~/.vim/bundle/Vundle.vim ] && git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
