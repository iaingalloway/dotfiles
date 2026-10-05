update-apt() {
  sudo apt update && sudo apt upgrade -y
}
alias au='update-apt'

reconcile-apt() {
  sudo apt update && xargs -r sudo apt install -y < "$HOME/.config/apt/packages"
}

update-ubuntu() {
  chezmoi update --apply && update-apt
}

reconcile-ubuntu() {
  chezmoi update --apply && reconcile-apt && update-apt
}

p() {
  pwsh.exe -Command "$*"
}

alias dfx='chezmoi update --apply && p "chezmoi update --apply"'

update-environment() {
  update-ubuntu && p Update-Windows
}
alias ue='update-environment'

reconcile-environment() {
  reconcile-ubuntu && p Reconcile-Windows
}
alias re='reconcile-environment'
