# Fish completion for dvc (devcontainer wrapper)

# Disable file completion for all dvc commands
complete -c dvc -f

# Container lifecycle commands
complete -c dvc -n __fish_use_subcommand -a up -d "Start devcontainer (create if needed)"
complete -c dvc -n __fish_use_subcommand -a start -d "Start devcontainer (create if needed)"
complete -c dvc -n __fish_use_subcommand -a stop -d "Stop container (keep it for later)"
complete -c dvc -n __fish_use_subcommand -a down -d "Stop and remove container"
complete -c dvc -n __fish_use_subcommand -a remove -d "Stop and remove container"
complete -c dvc -n __fish_use_subcommand -a restart -d "Stop and start container (without removing)"
complete -c dvc -n __fish_use_subcommand -a recreate -d "Remove and create new container"
complete -c dvc -n __fish_use_subcommand -a rebuild -d "Rebuild from scratch (remove image too)"

# Operations
complete -c dvc -n __fish_use_subcommand -a exec -d "Execute command in container"
complete -c dvc -n __fish_use_subcommand -a run -d "Execute command in container"
complete -c dvc -n __fish_use_subcommand -a shell -d "Open shell in container"
complete -c dvc -n __fish_use_subcommand -a sh -d "Open shell in container"
complete -c dvc -n __fish_use_subcommand -a logs -d "Show container logs"
complete -c dvc -n __fish_use_subcommand -a status -d "Show container status"
complete -c dvc -n __fish_use_subcommand -a ps -d "Show container status"
complete -c dvc -n __fish_use_subcommand -a clean -d "Clean up volumes and images"

# Claude integration
complete -c dvc -n __fish_use_subcommand -a claude -d "Start Claude Code"
complete -c dvc -n __fish_use_subcommand -a claude-resume -d "Resume Claude Code session"

# Other
complete -c dvc -n __fish_use_subcommand -a version -d "Show version information"
complete -c dvc -n __fish_use_subcommand -a help -d "Show help message"