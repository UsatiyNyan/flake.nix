{pkgs, ...}: {
  imports = [
    ./binds.nix
    ./bar.nix
    ./portal.nix
    ./lock.nix
    ./cursor.nix
    ./wallpaper.nix
  ];

  home.packages = with pkgs; [
    mako # notification daemon
    wl-clipboard
    cliphist
    rofi-wayland # applauncher
    brightnessctl
    hyprpicker
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      # TODO: auto-layout connected monitors
      monitor = [
        ",highres,auto,1"
        ",highres,auto-right,1"
      ];

      xwayland.force_zero_scaling = true;

      "$mainMod" = "SUPER";
      "$terminal" = "alacritty";
      "$appLauncher" = "rofi -show drun -show-icons";
      "$fileManager" = "thunar"; # configured from optional-configuration

      exec-once = [
        "waybar"
        "hyprpaper"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];

      misc = {
        # sorry Vaxry :( I already use hyprpaper, but default ones blink on startup
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };
    };
  };
}
