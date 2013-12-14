#!/bin/bash

cd $(dirname $0)
for FILE in *; do

    if [ $FILE == $(basename $0) ]; then
        continue
    fi

    SRC=$(pwd)/$FILE
    DEST=~/.$FILE

    echo "Replacing $DEST..."
    rm -f $DEST && ln -s $SRC $DEST

done
