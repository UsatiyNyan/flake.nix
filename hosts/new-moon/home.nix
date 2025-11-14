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

    desktop.sway
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

    # unfree
    google-chrome

    # STYLE
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term

    (import my.modules.ide.nixvim-standalone {inherit pkgs inputs my lib system user config;})
  ];
  home.sessionVariables.EDITOR = "nvim";

  fonts.fontconfig.enable = true;

  wayland.windowManager.sway = {
    config.output = {
      "$monitor0" = {
        mode = "1920x1200@60Hz";
        position = "0 0";
      };
      "$monitor1" = {
        mode = "2560x1440@120Hz";
        position = "1920 0";
      };
    };

    extraConfigEarly = ''
      set $monitor0 eDP-1
      set $monitor1 HDMI-A-1

      set $appLauncher rofi -show drun -show-icons
      set $fileManager nautilus
    '';
  };
}
