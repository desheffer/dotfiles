#!/bin/env bash

if [ ! -f /usr/local/bin/starship ]; then
    echo "Installing Starship..."
    sh -c "$(curl -fsSL https://starship.rs/install.sh)"
fi
