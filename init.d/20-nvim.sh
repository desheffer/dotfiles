#!/bin/env bash

# Set up NeoVim.
nvim --headless -c "autocmd User PackerComplete quitall" -c "PackerSync"

# Add dotfiles project.
PROJECTS="${HOME}/.local/share/nvim/telescope-projects.txt"
touch "${PROJECTS}"
if ! grep -q "^dotfiles=" "${PROJECTS}"; then
    echo "dotfiles=$(pwd)=1" >> "${PROJECTS}"
fi
