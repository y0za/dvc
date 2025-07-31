# dvc - DevContainer Wrapper

A simple POSIX-compliant wrapper for DevContainer CLI operations.

## Installation

### Quick Install (Recommended)

```bash
# Clone the repository
git clone https://github.com/y0za/dvc.git
cd dvc

# Run the installation script with your shell
bash install.sh  # for bash users
zsh install.sh   # for zsh users
fish install.sh  # for fish users
```

This will:
- Install `dvc` to `~/.local/bin` by default (or `/usr/local/bin` if you have write permission there)
- Automatically detect your shell and install the appropriate completion script
- Create necessary directories if they don't exist
- Warn if the install directory is not in your PATH

### Manual Install

```bash
# Clone the repository
git clone https://github.com/y0za/dvc.git
cd dvc

# Option 1: Add to PATH
sudo ln -s $(pwd)/dvc /usr/local/bin/dvc

# Option 2: Copy to PATH
sudo cp dvc /usr/local/bin/dvc
sudo chmod +x /usr/local/bin/dvc
```

### Install with Homebrew (macOS/Linux)

```bash
# If you create a homebrew formula
brew install y0za/tap/dvc
```


## Shell Completion

Shell completions are automatically installed when using `./install.sh`. 

For manual installation:

### Bash
```bash
# Copy to completion directory
sudo cp dvc-completion.bash /etc/bash_completion.d/dvc
# Or source directly in ~/.bashrc
source /path/to/dvc-completion.bash
```

### Zsh
```bash
# Copy to completion directory
sudo cp dvc-completion.zsh /usr/local/share/zsh/site-functions/_dvc
# Or source directly in ~/.zshrc
source /path/to/dvc-completion.zsh
```

### Fish
```bash
# Copy to fish completions directory
cp dvc-completion.fish ~/.config/fish/completions/dvc.fish
```

## Requirements

- Docker
- DevContainer CLI (`npm install -g @devcontainers/cli`)

## Usage

```bash
# Start devcontainer
dvc up

# Execute command in container
dvc exec npm test

# Open shell in container
dvc shell

# Stop container
dvc stop

# Remove container
dvc down

# Show help
dvc help
```

## License

MIT