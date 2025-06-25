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
    wl-clipboard
    cliphist
    brightnessctl
    hyprpicker
    hyprshot
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mainMod" = "SUPER";
      "$terminal" = "alacritty -e my-tmux-new";
      "$terminalTmux" = "alacritty -e my-tmux-attach";

      env = [
        "HYPRSHOT_DIR,$XDG_PICTURES_DIR/Screenshots"
      ];

      # TODO: auto-layout connected monitors
      monitor = [
        "$monitor0,highres,auto,1"
        "$monitor1,highres,auto-right,1"
      ];

      xwayland.force_zero_scaling = true;

      exec-once = [
        "systemctl --user start hyprpolkitagent"
        "waybar"
        "hyprpaper"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];

      workspace = [
        "1, monitor:$monitor0, persistent:true, on-created-empty:$terminalTmux, default: true"
        "2, monitor:$monitor0, persistent:true, on-created-empty:$webBrowser"
        "3, monitor:$monitor0, persistent:true, on-created-empty:$notesApp"
        "4, monitor:$monitor0, persistent:true, on-created-empty:$fileManager"
        "5, monitor:$monitor0, persistent:true, on-created-empty:$messagingApp"
      ];

      windowrule = [
      ];

      layerrule = [
        "blur, rofi"
      ];

      misc = {
        # sorry Vaxry :( I already use hyprpaper, but default ones blink on startup
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      general = {
        border_size = 0;
        gaps_in = 4;
        gaps_out = 0;
      };

      # for now, I'm dizzy
      animations.enabled = false;

      decoration = {
        # doesn't look good with waybar
        shadow.enabled = false;
      };
    };
  };
}
