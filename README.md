# My dotfiles

My dotfiles, managed with [chezmoi](https://www.chezmoi.io/).

On linux:

```bash
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --ssh --apply iaingalloway
```

On windows:

```powershell
winget install -e --id twpayne.chezmoi
chezmoi init --ssh --apply iaingalloway
```

Cheat sheet:

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
