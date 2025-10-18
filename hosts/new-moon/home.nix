{
  pkgs,
  my,
  ...
}: {
  imports = with my.modules; [
    dot.alacritty

    lang.nix
    lang.cpp
    lang.rust

    desktop.hyprland
    desktop.rofi
    desktop.mako
    desktop.gtk-theme

    ide.nixvim
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

    # unfree
    google-chrome

    # STYLE
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
  ];
  home.sessionVariables.EDITOR = "nvim";

  fonts.fontconfig.enable = true;

  wayland.windowManager.hyprland.settings = {
    "$monitor0" = "eDP-1";
    "$monitor1" = "DP-7";

    "$webBrowser" = "google-chrome-stable";
    "$appLauncher" = "rofi -show drun -show-icons";
    "$fileManager" = "nautilus"; # configured from optional-configuration
  };
}
