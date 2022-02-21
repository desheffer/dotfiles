#!/bin/env bash

function _nvim {
    nvim --headless '+lua vim.g.auto_session_enabled = false' "$@"
}

rm -f ~/.config/nvim/plugin/packer_compiled.lua

echo "Running Packer sync..."
_nvim -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

echo "Writing lock file..."
_nvim ~/.config/nvim/lua/plugins/lock.lua -c 'lua require("utilities.packer").generate_lock_file()' -c 'silent! write' -c 'quitall'

echo "Running LSP sync..."
_nvim -c 'lua require("utilities.lsp").install_sync()' -c 'quitall'

echo "Running Treesitter sync..."
_nvim -c 'lua require("utilities.treesitter").install_sync()' -c 'quitall'
