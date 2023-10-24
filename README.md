# My dotfiles

My dotfiles, managed by chezmoi.

On linux:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply iaingalloway
```

On windows:

```powershell
winget install -e --id twpayne.chezmoi
chezmoi init --apply iaingalloway
```
