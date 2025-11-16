{
  pkgs,
  my,
  inputs,
  system,
  lib,
  user,
  config,
  ...
}: {
  imports = with my.modules; [
    dot.alacritty

    desktop.hyprland
    desktop.rofi
    desktop.mako
    desktop.gtk-theme

    ide.aider

    utils.box
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # TERMINAL
    caligula

    # DESKTOP
    telegram-desktop
    pavucontrol
    seahorse
    gparted
    vlc
    obs-studio
    prismlauncher

    # unfree
    google-chrome

    # STYLE
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term

    (import my.modules.ide.nixvim-standalone {inherit pkgs inputs my lib system user config;})
  ];
  home.sessionVariables.EDITOR = "nvim";

  fonts.fontconfig.enable = true;

  wayland.windowManager.hyprland.settings = {
    "$monitor0" = "DP-7";

    "$appLauncher" = "rofi -show drun -show-icons";
    "$picker" = "rofi -dmenu";
    "$fileManager" = "nautilus";
  };

  hypridle.enableSuspend = false;
}
