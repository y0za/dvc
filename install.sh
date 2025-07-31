# Installation script for dvc
# Run this script with your shell: bash install.sh, zsh install.sh, etc.

set -e

# Default installation directory
# Prefer ~/.local/bin for user installation, fall back to /usr/local/bin
if [ -d "$HOME/.local/bin" ] || [ ! -w "/usr/local/bin" ]; then
    INSTALL_DIR="${INSTALL_DIR:-$HOME/.local/bin}"
else
    INSTALL_DIR="${INSTALL_DIR:-/usr/local/bin}"
fi
COMPLETION_DIR=""

# Detect shell
detect_shell() {
    # Check shell-specific variables
    if [ -n "$BASH_VERSION" ]; then
        echo "bash"
    elif [ -n "$ZSH_VERSION" ]; then
        echo "zsh"
    elif [ -n "$FISH_VERSION" ]; then
        echo "fish"
    else
        echo "unknown"
    fi
}

# Get completion directory for the shell
get_completion_dir() {
    case "$1" in
        bash)
            # Prefer user directory for easier installation
            if [ -d "$HOME/.bash_completion.d" ]; then
                echo "$HOME/.bash_completion.d"
            elif [ -w "/etc/bash_completion.d" ]; then
                echo "/etc/bash_completion.d"
            elif [ -w "/usr/local/etc/bash_completion.d" ]; then
                echo "/usr/local/etc/bash_completion.d"
            else
                # Create user directory if none exist
                echo "$HOME/.bash_completion.d"
            fi
            ;;
        zsh)
            # Prefer user directory for easier installation
            if [ -d "$HOME/.zsh/completions" ]; then
                echo "$HOME/.zsh/completions"
            elif [ -w "/usr/local/share/zsh/site-functions" ]; then
                echo "/usr/local/share/zsh/site-functions"
            elif [ -w "/usr/share/zsh/site-functions" ]; then
                echo "/usr/share/zsh/site-functions"
            else
                # Create user directory if none exist
                echo "$HOME/.zsh/completions"
            fi
            ;;
        fish)
            echo "$HOME/.config/fish/completions"
            ;;
    esac
}

# Main installation
main() {
    echo "Installing dvc..."

    # Check if running from the repo
    if [ ! -f "./dvc" ]; then
        echo "Error: dvc script not found. Please run this script from the dvc repository."
        exit 1
    fi

    # Create install directory if needed
    if [ ! -d "$INSTALL_DIR" ]; then
        echo "Creating directory $INSTALL_DIR..."
        mkdir -p "$INSTALL_DIR"
    fi

    # Install main script
    echo "Installing dvc to $INSTALL_DIR..."
    if [ -w "$INSTALL_DIR" ]; then
        cp ./dvc "$INSTALL_DIR/dvc"
        chmod +x "$INSTALL_DIR/dvc"
    else
        echo "Need sudo permission to install to $INSTALL_DIR"
        sudo cp ./dvc "$INSTALL_DIR/dvc"
        sudo chmod +x "$INSTALL_DIR/dvc"
    fi

    # Check if install directory is in PATH
    if ! echo "$PATH" | grep -q "$INSTALL_DIR"; then
        echo
        echo "WARNING: $INSTALL_DIR is not in your PATH."
        echo "Add the following line to your shell configuration file:"
        echo "  export PATH=\"$INSTALL_DIR:\$PATH\""
    fi

    # Detect shell and install completion
    SHELL_TYPE=$(detect_shell)
    echo "Detected shell: $SHELL_TYPE"

    case "$SHELL_TYPE" in
        bash)
            if [ -f "./dvc-completion.bash" ]; then
                COMPLETION_DIR=$(get_completion_dir bash)
                mkdir -p "$COMPLETION_DIR" 2>/dev/null || true
                echo "Installing bash completion to $COMPLETION_DIR..."
                cp ./dvc-completion.bash "$COMPLETION_DIR/dvc"
            fi
            ;;
        zsh)
            if [ -f "./dvc-completion.zsh" ]; then
                COMPLETION_DIR=$(get_completion_dir zsh)
                mkdir -p "$COMPLETION_DIR" 2>/dev/null || true
                echo "Installing zsh completion to $COMPLETION_DIR..."
                cp ./dvc-completion.zsh "$COMPLETION_DIR/_dvc"
            fi
            ;;
        fish)
            if [ -f "./dvc-completion.fish" ]; then
                COMPLETION_DIR=$(get_completion_dir fish)
                mkdir -p "$COMPLETION_DIR" 2>/dev/null || true
                echo "Installing fish completion to $COMPLETION_DIR..."
                cp ./dvc-completion.fish "$COMPLETION_DIR/dvc.fish"
            fi
            ;;
        unknown)
            echo
            echo "WARNING: Could not detect shell type."
            echo "Please run this script with your shell:"
            echo "  bash install.sh"
            echo "  zsh install.sh"
            echo "  fish install.sh"
            echo
            echo "Skipping shell completion installation."
            ;;
    esac

    echo
    echo "Installation complete!"
    echo
    echo "dvc has been installed to: $INSTALL_DIR/dvc"
    if [ -n "$COMPLETION_DIR" ]; then
        echo "Shell completion installed to: $COMPLETION_DIR"
        echo
        echo "You may need to restart your shell or run:"
        case "$SHELL_TYPE" in
            bash) echo "  source ~/.bashrc" ;;
            zsh) 
                echo "  source ~/.zshrc"
                echo
                echo "For zsh completion to work, ensure your ~/.zshrc contains:"
                echo "  fpath=(~/.zsh/completions \$fpath)"
                echo "  autoload -Uz compinit && compinit -u"
                ;;
            fish) echo "  source ~/.config/fish/config.fish" ;;
        esac
    fi
    echo
    echo "Run 'dvc help' to get started."
}

main "$@"