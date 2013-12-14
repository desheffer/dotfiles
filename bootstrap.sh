#!/bin/bash

cd "$(dirname $0)"
HERE="$(pwd)"

for FILE in *; do

    [ "$FILE" == "$(basename $0)" ] && continue
    [[ "$FILE" == README* ]] && continue

    SRC="$HERE/$FILE"
    DEST="$HOME/.$FILE"

    echo "Installing $DEST..."
    rm -f "$DEST" && ln -s "$SRC" "$DEST"

done
