#compdef dvc
# Zsh completion for dvc (devcontainer wrapper)

_dvc() {
    local -a commands
    commands=(
        'up:Start devcontainer (create if needed)'
        'start:Start devcontainer (create if needed)'
        'stop:Stop container (keep it for later)'
        'down:Stop and remove container'
        'remove:Stop and remove container'
        'restart:Stop and start container (without removing)'
        'recreate:Remove and create new container'
        'exec:Execute command in container'
        'run:Execute command in container'
        'shell:Open shell in container'
        'sh:Open shell in container'
        'rebuild:Rebuild from scratch (remove image too)'
        'logs:Show container logs'
        'status:Show container status'
        'ps:Show container status'
        'clean:Clean up volumes and images'
        'claude:Start Claude Code'
        'claude-resume:Resume Claude Code session'
        'version:Show version information'
        'help:Show help message'
    )

    if (( CURRENT == 2 )); then
        _describe -t commands 'dvc command' commands
    fi
}

_dvc "$@"