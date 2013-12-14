#!/bin/bash

cd "$(dirname $0)"
HERE="$(pwd)"

STASH="$HERE/.stash/$(date +%s)"
REVERT="$STASH/revert"

for FILE in *; do

    [ "$FILE" == "$(basename $0)" ] && continue
    [[ "$FILE" == README* ]] && continue

    SRC="$HERE/$FILE"
    DEST="$HOME/.$FILE"
    echo "Installing $DEST..."

    # Move any existing files into the stash.
    if [ ! -L "$DEST" ]; then
        mkdir -p "$STASH"

        STASHFILE="$STASH/.$FILE"
        mv "$DEST" "$STASHFILE"
        echo "Stashed existing file to $STASHFILE"

        echo "# Revert .$FILE" >> "$REVERT"
        echo "rm -f '$DEST'" >> "$REVERT"
        echo "cp '$STASHFILE' '$DEST'" >> "$REVERT"
        echo >> "$REVERT"
    fi

    # Link the new file into place.
    rm -f "$DEST" && ln -s "$SRC" "$DEST"

done

if [ -e "$REVERT" ]; then
    echo "Revert log stored to $REVERT"
fi
