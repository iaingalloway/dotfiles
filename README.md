# My dotfiles

My dotfiles, managed with [chezmoi](https://www.chezmoi.io/).

## Prerequisites

- [Git](https://git-scm.com/)
- [Chezmoi](https://www.chezmoi.io/)
- [Starship](https://starship.rs/)
- Optionally:
  - [Nix](https://nixos.org/)
  - [Direnv](https://direnv.net/)

## Installation

On Ubuntu on WSL:

```bash
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon

sudo apt upgrade && sudo apt install -y direnv

curl -sS https://starship.rs/install.sh | sh

sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --ssh --apply iaingalloway
```

On Windows:

```powershell
winget install -e --id Git.Git
winget install -e --id Starship.Starship
winget install -e --id twpayne.chezmoi

chezmoi init --ssh --apply iaingalloway
```

## Cheat sheet

```bash
# open a subshell in chezmoi's source directory
chezmoi cd

# get changes from github and apply
chezmoi update

# add file foo to chezmoi
chezmoi add foo

# add all modified files in their target state
chezmoi re-add
```
