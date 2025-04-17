{...}: {
  programs.git = {
    enable = true;
    userName = "Andreas Krath";
    userEmail = "andreas.krath+github@gmail.com";
    signing.format = "ssh";

    extraConfig = {
      commit.gpgsign = true; # sign all commits using ssh key
      gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      user.signingkey = "~/.ssh/id_ed25519.pub";
    };
  };
}
