# dotfiles

These are my personal dotfiles for various Unix utilities.  If you find these
files useful, then you are free to use them however you see fit.

## Installation

Run `install.sh`.  This will link the files into your home directory and
install (most of) the required dependencies.

To enable symbols, you will need to download and install one of the patched
[Nerd Fonts](https://github.com/ryanoasis/nerd-fonts) for your terminal.

## Secrets

Secrets are files that you don't want exposed to the world.  These can be
managed using the `secrets.sh` script.  This script acts as wrappers around
`lpass` and is capable of moving files into and out of your LastPass vault.

To get started:

    lpass login yourname@example.com
    secrets.sh help
