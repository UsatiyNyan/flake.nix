{pkgs, ...}: {
  imports = [
    ./binds.nix
    ./bar.nix
    ./portal.nix
  ];

  home.packages = with pkgs; [
    mako # notification daemon
    wl-clipboard
    rofi-wayland # applauncher
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mainMod" = "SUPER";
      "$terminal" = "alacritty";
      "$appLauncher" = "rofi -show drun -show-icons";

      "input:touchpad" = {
        natural_scroll = "true";
      };
    };
  };
}
