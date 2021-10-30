#!/bin/env bash

# Set up NeoVim.
nvim --headless -c "autocmd User PackerComplete quitall" -c "PackerSync"
