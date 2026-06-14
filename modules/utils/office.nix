{
  pkgs,
  pkgs-unstable,
  ...
}: {
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
      (callPackage ./detail/helium.nix {})

      # unfree :(
      google-chrome
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
