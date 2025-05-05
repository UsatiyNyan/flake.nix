{pkgs, ...}: {
  imports = [
    ./binds.nix
    ./bar.nix
    ./portal.nix
    ./lock.nix
  ];

  home.packages = with pkgs; [
    mako # notification daemon
    wl-clipboard
    rofi-wayland # applauncher
    brightnessctl
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      # TODO: auto-layout connected monitors
      monitor = [
        ",1920x1200@60,0x0,1"
        # ",1920x1080@60,1920x0,1"
      ];

      "$mainMod" = "SUPER";
      "$terminal" = "alacritty";
      "$appLauncher" = "rofi -show drun -show-icons";
      "$fileManager" = "thunar"; # configured from optional-configuration

      "input:touchpad" = {
        natural_scroll = "true";
      };
    };
  };
}
