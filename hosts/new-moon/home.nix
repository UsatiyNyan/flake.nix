{ pkgs, my, ... }:
{
  imports = with my.modules; [
    lang.cpp
    lang.lua
    lang.rust
  ];
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # DESKTOP
    obsidian
    telegram-desktop
    brave
    google-chrome # unfree
  ];
}
