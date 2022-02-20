#!/bin/env bash

function _nvim {
    nvim --headless '+lua vim.g.auto_session_enabled = false' "$@"
}

# Set up Neovim.
rm -f ~/.config/nvim/plugin/packer_compiled.lua
_nvim -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
_nvim -c 'lua require("utilities.lsp").install_sync()' -c 'quitall'
_nvim -c 'lua require("utilities.treesitter").install_sync()' -c 'quitall'
