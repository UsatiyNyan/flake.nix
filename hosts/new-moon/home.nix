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
    # TERMINAL
    tldr

    # DESKTOP
    obsidian
    telegram-desktop
    brave
    google-chrome # unfree
  ];
}
