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
    desktop.rofi
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # TERMINAL
    ncspot

    # DESKTOP
    telegram-desktop
    pavucontrol
    seahorse

    # unfree
    obsidian
    google-chrome
  ];

  wayland.windowManager.hyprland.settings = {
    "$monitor0" = "eDP-1";
    "$monitor1" = "DP-7";

    "$webBrowser" = "google-chrome-stable";
    "$notesApp" = "obsidian";
    "$appLauncher" = "rofi -show drun -show-icons";
    "$fileManager" = "dolphin"; # configured from optional-configuration
  };
}
