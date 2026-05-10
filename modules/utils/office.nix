{pkgs, ...}: {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # DESKTOP
    telegram-desktop
    pavucontrol
    seahorse
    gparted
    vlc
    obs-studio
    sioyek

    # unfree
    google-chrome
    brave
    obsidian
  ];

  home.shellAliases = {
    pdf = "sioyek";
  };
}
