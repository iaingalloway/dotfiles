if [ -f /etc/bash_completion.d/docker ]; then
    source /etc/bash_completion.d/docker &> /dev/null || true
elif [ -f /usr/share/bash-completion/completions/docker ]; then
    source /usr/share/bash-completion/completions/docker &> /dev/null || true
fi

alias d=docker
alias dr='docker run --rm -it'
alias de='docker exec -it'

if declare -F __start_docker &> /dev/null; then
  complete -F __start_docker d
fi

alias dprune='docker-cache-prune && docker-image-prune'

docker-cache-prune() {
  docker buildx prune -af --filter "until=336h"
}

docker-image-prune() {
  local dry="${1:-}"
  local keep_file="${HOME}/.config/.dockerkeep"

  ids_to_keep=$(
    {
      docker ps -aq | xargs -r docker inspect --format '{{.Image}}' 2>/dev/null

      if [[ -f "$keep_file" ]]; then
        while IFS= read -r ref; do
          [[ -z "$ref" ]] && continue
          docker image inspect --format '{{.ID}}' "$ref" 2>/dev/null || true
        done < "$keep_file"
      fi
    } | sort -u
  )

  all_ids=$(docker image ls -q --no-trunc | sort -u)

  to_remove=$(comm -23 <(echo "$all_ids") <(echo "$ids_to_keep"))

  if [[ -n "$dry" ]]; then
    echo "$to_remove"
  else
    echo "$to_remove" | xargs -r docker image rm
  fi
}

_docker_run_completion() {
    COMP_WORDS=(docker run "${COMP_WORDS[@]:1}")
    COMP_CWORD=$((COMP_CWORD+1))
    __start_docker
}

_docker_exec_completion() {
    COMP_WORDS=(docker exec "${COMP_WORDS[@]:1}")
    COMP_CWORD=$((COMP_CWORD+1))
    __start_docker
}

if declare -F __start_docker &> /dev/null; then
  complete -F _docker_run_completion dr
  complete -F _docker_exec_completion de
fi
