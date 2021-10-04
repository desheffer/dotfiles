#!/bin/env bash

# Set up NeoVim.
nvim -c "autocmd User PackerComplete quitall" -c "PackerSync"
