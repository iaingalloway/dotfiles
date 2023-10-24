# My dotfiles

My dotfiles, managed by [chezmoi](https://www.chezmoi.io/).

On linux:

```bash
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply iaingalloway
```

On windows:

```powershell
winget install -e --id twpayne.chezmoi
chezmoi init --apply iaingalloway
```
