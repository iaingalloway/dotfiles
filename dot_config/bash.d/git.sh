if [ -r /usr/share/bash-completion/completions/git ]; then
  source /usr/share/bash-completion/completions/git
fi

alias g=git
alias gr='cd $(git rev-parse --show-toplevel)'
alias gs='git status'
alias ga='git add'
alias gl='git l'

if declare -F __git_complete &> /dev/null; then
  __git_complete g __git_main
  __git_complete gs _git_status
  __git_complete ga _git_add
  __git_complete gl _git_log
fi

_git_ac() {
  _git_add
}
