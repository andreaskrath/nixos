{pkgs, ...}: {
  system.stateVersion = "23.05";

  time.timeZone = "Europe/Copenhagen";

  i18n = {
    defaultLocale = "en_DK.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "da_DK.UTF-8";
      LC_IDENTIFICATION = "da_DK.UTF-8";
      LC_MEASUREMENT = "da_DK.UTF-8";
      LC_MONETARY = "da_DK.UTF-8";
      LC_NAME = "da_DK.UTF-8";
      LC_NUMERIC = "da_DK.UTF-8";
      LC_PAPER = "da_DK.UTF-8";
      LC_TELEPHONE = "da_DK.UTF-8";
      LC_TIME = "da_DK.UTF-8";
    };
  };

  console.keyMap = "dk-latin1";

  services.printing.enable = true;

  environment.shells = with pkgs; [zsh];
  users.defaultUserShell = pkgs.zsh;
  users.users.krath = {
    isNormalUser = true;
    description = "krath";
    extraGroups = ["networkmanager" "wheel" "docker" "dialout" "video"];
  };
  programs.zsh.enable = true;

  nixpkgs.config.allowUnfree = true;
}
