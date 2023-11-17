{ pkgs,... }:
let
  owner = "andreaskrath";
  repo = "justfiles";
  branch = "master";
in
{
  home.packages = with pkgs; [
    curl
  ];
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      xo = "xdg-open";
      ll = "ls -l";
      la = "ls -A";
      cat = "bat";
      ".." = "cd ../";
      "...." = "cd ../../";
      "......" = "cd ../../../";
      update = "sudo nixos-rebuild switch";
      lg = "lazygit";
    };

    initExtra = ''
      eval "$(direnv hook zsh)"

      # a function to fetch a justfile for a given language based on the first argument
      just_get() {
        lang=$1

        if [ -z "$1" ]; then
          echo "Please specify the language of the justfile you are interested in getting."
          return 1
        fi
        
        repo_url="https://raw.githubusercontent.com/${owner}/${repo}/${branch}/$lang/justfile"

        content=$(${pkgs.curl}/bin/curl -s $repo_url)

        if [ $? -eq 0 ]; then
          echo "$content" > justfile
          echo "Fetched $lang justfile and saved as 'justfile'."
          echo "Make sure to check the contents of the justfile, and make appropriate modifications if necessary:"
          ${pkgs.bat}/bin/bat justfile        
        else
          echo "Could not fetch $lang justfile from the repository. Ensure that '$lang' is spelled correctly and matches a justfile in the repository."
        fi
      }

      # a function to setup direnv based on predefined shells in /etc/nix/shells
      setup_env() {
        if [ -z "$1" ]; then
          echo "Please specify which shell you wish to utilize. Available options are:"
          ls /etc/nixos/shells
          return 1
        fi

        echo "use nix" > .envrc
        echo "(import /etc/nixos/shells/$1.nix)" > shell.nix
        direnv allow

        echo "Nix environment setup is complete."
      }
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
  };
}
