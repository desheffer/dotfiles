#!/bin/env bash

# Set up Neovim.
rm -f ~/.config/nvim/plugin/packer_compiled.lua
nvim --headless -c "autocmd User PackerComplete quitall" -c "PackerSync"
nvim --headless -c "lua ts_install_sync()" -c "quitall"
nvim --headless -c "lua lsp_install_sync()" -c "quitall"

# Add dotfiles project.
PROJECTS="${HOME}/.local/share/nvim/telescope-projects.txt"
touch "${PROJECTS}"
if ! grep -q "^dotfiles=" "${PROJECTS}"; then
    echo "dotfiles=$(pwd)=1" >> "${PROJECTS}"
fi
