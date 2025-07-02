{pkgs}:
pkgs.writeShellApplication {
  name = "dev";
  runtimeInputs = with pkgs; [findutils coreutils gnused];
  text = ''
    set -euo pipefail

    # Script to set up a direnv environment with a Nix flake template

    # Get the parameter or use default
    TEMPLATE="''${1:-default}"

    # Source and destination paths
    SOURCE_FILE="/etc/nixos/shells/''${TEMPLATE}.nix"
    DEST_FILE="flake.nix"
    ENVRC_FILE=".envrc"

    # Check if source file exists
    if [[ ! -f "$SOURCE_FILE" ]]; then
        echo "Error: Template file '$SOURCE_FILE' not found!" >&2
        echo "Available templates:" >&2
        find /etc/nixos/shells -maxdepth 1 -name "*.nix" -type f -exec basename {} \; 2>/dev/null | sed 's/\.nix$//' | sed 's/^/  - /' | sort >&2
        exit 1
    fi

    # Check if direnv is installed
    if ! command -v direnv &> /dev/null; then
        echo "Error: direnv is not installed or not in PATH!" >&2
        echo "Please install direnv first." >&2
        exit 1
    fi

    # Check if flake.nix already exists
    if [[ -f "$DEST_FILE" ]]; then
        echo "Warning: $DEST_FILE already exists in current directory!" >&2
        read -p "Overwrite? (y/N) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "Aborted."
            exit 1
        fi
    fi

    # Copy the template file
    echo "Copying $SOURCE_FILE to $DEST_FILE..."
    if ! cp "$SOURCE_FILE" "$DEST_FILE"; then
        echo "Error: Failed to copy template file!" >&2
        exit 1
    fi

    # Create .envrc file
    echo "Creating $ENVRC_FILE..."
    if ! echo "use flake" > "$ENVRC_FILE"; then
        echo "Error: Failed to create .envrc file!" >&2
        exit 1
    fi

    # Run direnv allow
    echo "Running direnv allow..."
    if ! direnv allow; then
        echo "Error: Failed to run 'direnv allow'!" >&2
        echo "Make sure direnv is installed and properly configured." >&2
        exit 1
    fi

    echo "Done! Your Nix flake environment is ready."
    echo "The direnv environment should now be active in this directory."
  '';
}
