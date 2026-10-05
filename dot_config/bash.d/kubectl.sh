if command -v kubectl &> /dev/null; then
  source <(kubectl completion bash)
  complete -o default -F __start_kubectl k
fi

alias k=kubectl
alias kclear='kubectl config unset current-context'
alias klist='kubectl config get-contexts'
alias kuse='kubectl config use-context'

kdelete() {
    context_name=$1
    current_context=$(kubectl config current-context)
    if [ "$current_context" == "$context_name" ]; then
        kubectl config unset current-context
    fi
    cluster=$(kubectl config view -o jsonpath="{.contexts[?(@.name == '\''$context_name'\'')].context.cluster}")
    user=$(kubectl config view -o jsonpath="{.contexts[?(@.name == '\''$context_name'\'')].context.user}")
    kubectl config delete-context $context_name
    kubectl config delete-cluster $cluster
    kubectl config delete-user $user
}

_kubectl_contexts()
{
    local cur
    cur="${COMP_WORDS[COMP_CWORD]}"
    COMPREPLY=( $( compgen -W "$(kubectl config get-contexts --output='name')" -- "$cur" ) )
}

if command -v kubectl &> /dev/null; then
  complete -F _kubectl_contexts kuse
  complete -F _kubectl_contexts kdelete
fi
