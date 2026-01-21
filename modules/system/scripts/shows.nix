{pkgs}:
pkgs.writeShellApplication {
  name = "shows";
  runtimeInputs = with pkgs; [fzf findutils coreutils];
  text = ''
    set -euo pipefail

    OUTPUT_BASE="/srv/media/shows"
    current_dir="$(pwd)"

    # Check if any shows exist
    existing_shows=$(find "$OUTPUT_BASE" -maxdepth 1 -mindepth 1 -type d 2>/dev/null | wc -l)

    if [ "$existing_shows" -gt 0 ]; then
      echo -n "Add to (e)xisting show or create (n)ew show? [e/n]: "
      read -r choice

      if [ "$choice" = "e" ]; then
        title=$(find "$OUTPUT_BASE" -maxdepth 1 -mindepth 1 -type d | sed "s|$OUTPUT_BASE/||" | sort | fzf --height 40% --layout=reverse --border --prompt="Select show: ")
      else
        echo -n "Enter title: "
        read -r title
      fi
    else
      echo -n "Enter title: "
      read -r title
    fi

    show_path="$OUTPUT_BASE/$title"

    echo "Select folders (use TAB to mark/unmark, ENTER when done):"
    mapfile -t folders < <(find "$current_dir" -maxdepth 1 -type d -not -path "$current_dir" | sort | sed "s|$current_dir/||" | fzf --multi --height 40% --layout=reverse --border --prompt="Select folders (TAB to select, ENTER to confirm): ")

    mkdir -p "$show_path"

    start_season=1
    if [ -d "$show_path" ]; then
      highest=$(find "$show_path" -maxdepth 1 -type d -name "Season *" | sed 's/.*Season 0*//' | sort -n | tail -1)
      if [ -n "$highest" ]; then
        start_season=$((highest + 1))
        echo "Found existing seasons, starting from Season $start_season"
      fi
    fi

    if [ ''${#folders[@]} -gt 0 ]; then
      echo "Selected folders: ''${folders[*]}"
      echo "Creating show at: $show_path"

      for i in "''${!folders[@]}"; do
        season_num=$((start_season + i))
        if [ "$season_num" -lt 10 ]; then
            season_dir="Season 0$season_num"
        else
            season_dir="Season $season_num"
        fi

        mkdir -p "$show_path/$season_dir"

        folder_path="$current_dir/''${folders[$i]}"
        if [ -d "$folder_path" ]; then
          echo "Moving from ''${folders[$i]} to $show_path/$season_dir/ and deleting source folder"
          mv "$folder_path"/* "$show_path/$season_dir/" 2>/dev/null || true
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
