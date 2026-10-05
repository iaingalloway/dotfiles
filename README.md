# My dotfiles

My dotfiles, managed with [chezmoi](https://www.chezmoi.io/).

## Prerequisites

- [Git](https://git-scm.com/)
- [Chezmoi](https://www.chezmoi.io/)

## Installation

On Ubuntu on WSL:

```bash
curl -sS https://starship.rs/install.sh | sh
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --ssh --apply iaingalloway

reconcile-environment
```

On Windows:

```powershell
winget install -e --id Git.Git
winget install -e --id twpayne.chezmoi

chezmoi init --ssh --apply iaingalloway

# Start a new PowerShell session, then run:
Reconcile-Environment
```

If WSL is installed for the first time, restart Windows when prompted, launch Ubuntu to create its Linux user, then run `ue` from PowerShell or WSL.

Docker Desktop must be launched once after installation. Enable **Use the WSL 2 based engine** and Ubuntu under **Settings > Resources > WSL Integration**.

## Apply updates

Aliases are provided in both Bash and PowerShell to reconcile (`re`) and update (`ue`) the environment.

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

```powershell
# validate a WinGet configuration file
winget configure validate --file "$HOME\.config\winget\core.winget"
```
