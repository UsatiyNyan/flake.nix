{pkgs, ...}: {
  imports = [
    ./binds.nix
    ./bar.nix
    ./portal.nix
  ];

  home.packages = with pkgs; [
    mako # notification daemon
    wl-clipboard
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mainMod" = "SUPER";
      "$terminal" = "alacritty";

      "input:touchpad" = {
        natural_scroll = "true";
      };
    };
  };
}
