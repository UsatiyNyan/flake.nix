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
    dot.direnv

    desktop.sway
    desktop.rofi
    desktop.mako
    desktop.gtk-theme

    ide.ai

    utils.box
    utils.office
    utils.games
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # TERMINAL
    caligula

    # STYLE
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term

    (inputs.l4y3r.lib.nixvim {inherit pkgs inputs my lib system user config;})
  ];
  home.sessionVariables.EDITOR = "nvim";

  fonts.fontconfig.enable = true;

  swayidle.enableSuspend = false;

  wayland.windowManager.sway = {
    config.output = {
      "$monitor0" = {
        mode = "2560x1440@120Hz";
        position = "0 0";
      };
    };

    extraConfigEarly = ''
      set $monitor0 DP-6

      set $appLauncher rofi -show drun -show-icons
      set $picker rofi -dmenu
      set $fileManager nautilus
    '';
  };
}
