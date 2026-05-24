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
      pipewire
      kdePackages.kdenlive
      gimp

      # unfree
      google-chrome
      brave
      obsidian
    ])
    ++ (
      with pkgs-unstable; [
        yt-dlp
        sioyek
      ]
    );

  home.shellAliases = {
    pdf = "sioyek";
  };
}
