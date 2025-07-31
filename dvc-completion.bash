#!/bin/bash
# Bash completion for dvc (devcontainer wrapper)

_dvc_completions() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    # Main commands
    local commands="up start stop down remove restart recreate exec run shell sh rebuild logs status ps clean claude claude-resume version help"

    # Handle first argument (commands)
    if [ $COMP_CWORD -eq 1 ]; then
        COMPREPLY=( $(compgen -W "${commands}" -- ${cur}) )
        return 0
    fi
}

complete -F _dvc_completions dvc