{
  pkgs,
  my,
  ...
}: {
  imports = with my.modules; [
    lang.nix
    lang.cpp
    lang.lua
    lang.rust
    lang.haskell

    desktop.hyprland
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # DESKTOP
    telegram-desktop
    pavucontrol
    seahorse

    # unfree
    obsidian
    google-chrome
  ];
}
