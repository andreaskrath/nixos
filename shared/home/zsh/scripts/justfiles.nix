{ pkgs }:
let
  baseUrl = "https://raw.githubusercontent.com";
  owner = "andreaskrath";
  repo = "justfiles";
  branch = "master";
in
pkgs.writeShellApplication {
  name = "justfile";
  runtimeInputs = with pkgs; [
    curl
    bat
  ];
  text = ''
    set +o nounset
  
    if [ -z "$1" ]; then
      echo "Please specify the language of the justfile you are interested in getting."
      exit 1
    fi

    repo_url="${baseUrl}/${owner}/${repo}/${branch}/$1/justfile"

    if content=$(curl -s "$repo_url"); then
      echo "$content" > justfile
      echo "Fetched $1 justfile and saved as 'justfile'"
      echo "Make sure to check the contents of the justfile, and make appropriate modifications if necessary:"
      bat justfile
    else
      echo "Could not fetch $1 justfile from the repository. Ensure that '$1' is spelled correctly and matches a justfile in the repository."
    fi
  '';
}
