{ lib, config, pkgs, user, my, ... }:
{
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
