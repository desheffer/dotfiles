#!/bin/env bash

# Set up NeoVim.
rm -rf ~/.config/nvim/plugin
nvim -c "autocmd User PackerComplete quitall" -c "PackerSync"
