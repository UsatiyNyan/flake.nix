{
  pkgs,
  pkgs-unstable,
  ...
}: {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  home.packages =
    (with pkgs; [
      # DESKTOP
      telegram-desktop
      pavucontrol
      seahorse
      gparted
      vlc
      mpv
      obs-studio
      sioyek

      # unfree
      google-chrome
      brave
      obsidian
    ])
    ++ (
      with pkgs-unstable; [
        yt-dlp
      ]
    );

  home.shellAliases = {
    pdf = "sioyek";
  };
}
