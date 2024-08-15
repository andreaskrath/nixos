{...}: {
  programs.git = {
    enable = true;
    userName = "Andreas Krath";
    userEmail = "andreas.krath+github@gmail.com";

    extraConfig = {
      commit.gpgsign = true; # sign all commits using ssh key
      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      user.signingkey = "~/.ssh/id_ed25519.pub";
    };
  };

  programs.lazygit = {
    enable = true;
    settings = {
      promptToReturnFromSubprocess = false;
      gui = {
        border = "single";
        mouseEvents = false;
        showBottomLine = false;
        mainPanelSplitMode = "horizontal";
      };
    };
  };
}
