{pkgs}:
pkgs.writeShellApplication {
  name = "shows";
  runtimeInputs = with pkgs; [fzf findutils coreutils];
  text = ''
    set -euo pipefail

    # Define the base output directory
    OUTPUT_BASE="/srv/media/shows"

    # Get the directory where the script is run from
    current_dir="$(pwd)"

    # Prompt for title
    echo -n "Enter title: "
    read -r title

    # Set the full output path
    show_path="$OUTPUT_BASE/$title"

    # Use fzf to select multiple folders
    echo "Select folders (use TAB to mark/unmark, ENTER when done):"
    mapfile -t folders < <(find "$current_dir" -maxdepth 1 -type d -not -path "$current_dir" | sort | sed "s|$current_dir/||" | fzf --multi --height 40% --layout=reverse --border --prompt="Select folders (TAB to select, ENTER to confirm): ")

    # Ensure the output directory exists
    mkdir -p "$show_path"

    # Check if folders were selected
    if [ ''${#folders[@]} -gt 0 ]; then
      echo "Selected folders: ''${folders[*]}"
      echo "Creating show at: $show_path"

      for i in "''${!folders[@]}"; do
        season_num=$((i+1))
        if [ "$season_num" -lt 10 ]; then
            season_dir="Season 0$season_num"
        else
            season_dir="Season $season_num"
        fi

        # Create the season directory under the show path
        mkdir -p "$show_path/$season_dir"

        # Check if the source folder exists before moving
        folder_path="$current_dir/''${folders[$i]}"
        if [ -d "$folder_path" ]; then
          echo "Moving from ''${folders[$i]} to $show_path/$season_dir/ and deleting source folder"
          # Move the contents
          mv "$folder_path"/* "$show_path/$season_dir/" 2>/dev/null || true
          # Delete the source folder
          rm -rf "$folder_path"
        else
          echo "Warning: Folder ''${folders[$i]} does not exist, skipping."
        fi
      done
    else
      echo "No folders selected."
    fi

    echo "Done"
  '';
}
