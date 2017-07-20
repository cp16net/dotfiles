#!/bin/bash
# My Aliases

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
alias remove_all_pyc_files='find . -name "*.pyc" -exec rm -rf {} \;'
alias wb='cd ~/wayblazer'

# kube aliases

alias k="kubectl"
alias kd="kubectl describe"
alias kg="kubectl get"
alias kc="kubectl create"
alias kdel="kubectl delete"
alias ke="kubectl exec -it"
alias kdes="kubectl describe"
alias kl="kubectl logs"

setns() {
    export CONTEXT=$(kubectl config view | grep current-context | awk '{print $2}')
    kubectl config set-context $CONTEXT --namespace=$1
}

setcontext() {
    kubectl config use-context $1
}

if [ -f ~/.bash_aliases ]; then
   . ~/.local.bash_aliases
fi

# i dont use this alias and now i have rd as a rundeck cli tool
unalias rd

alias pbcopy='xsel --clipboard --input'
