if command -v just &> /dev/null; then
  source <(just --completions bash)
  complete -o bashdefault -o nosort -o nospace -F _clap_complete_just j
fi

alias j=just
