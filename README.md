# dotfiles

These are my personal dotfiles for various Linux utilities.

## Dependencies

The following are (mostly) required:

* `stow`
* `zsh`
* `starship`
* `neovim`
* `tmux`
* [Nerd Fonts][Nerd Fonts], e.g. `nerd-fonts-jetbrains-mono`

The following are required for Neovim LSP support:

* `dotnet-runtime`
* `gcc`
* `go`
* `jdk-openjdk`
* `npm`
* `php` and `composer`

## Testing

To test using Docker:

```sh
docker run -it --rm archlinux bash -c "
    pacman -Syyu --noconfirm dotnet-runtime gcc git go jdk-openjdk neovim npm starship stow unzip wget zsh &&
    git clone https://github.com/desheffer/dotfiles.git ~/dotfiles &&
    ~/dotfiles/install.sh -f &&
    zsh"
```

## Installation

To install:

```sh
./install.sh
```

This will link the files into your home directory and set up Neovim.

## Secrets

Secrets are files that you don't want exposed to the world. These can be
managed using the `secrets.sh` script. This script acts as wrappers around
`lpass` and is capable of moving files into and out of your LastPass vault.

To get started:

```sh
lpass login yourname@example.com
./secrets.sh help
```
[Nerd Fonts]: https://github.com/ryanoasis/nerd-fonts
