{
  config,
  pkgs,
  ...
}: {
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
  ];

  wayland.windowManager.sway = {
    enable = true;

    xwayland = true;
    wrapperFeatures = {
      gtk = true;
    };

    extraConfigEarly = ''
      set $terminal alacritty -e my-tmux-new
      set $terminalTmux alacritty -e my-tmux-attach
      set $mod ${config.wayland.windowManager.sway.config.modifier}
    '';

    config = {
      modifier = "Mod4"; # SUPER key
      terminal = "alacritty -e my-tmux-new";

      startup = [
        {command = "systemctl --user start polkit-gnome-authentication-agent-1";}
        {command = "swaybg -i ${config.xdg.userDirs.pictures}/wallpaper.jpg --mode fill";}
        {command = "wl-paste --type text --watch cliphist store";}
        {command = "wl-paste --type image --watch cliphist store";}
      ];

      defaultWorkspace = "workspace number 1";
      workspaceLayout = "default";

      window = {
        border = 0;
        hideEdgeBorders = "both";
        titlebar = false;
      };

      gaps = {
        inner = 0;
        outer = 0;
      };
    };

    extraConfig = ''
      workspace "1" output "$monitor0"
      workspace "2" output "$monitor0"
      workspace "3" output "$monitor0"
      workspace "4" output "$monitor0"
      workspace "5" output "$monitor0"
      workspace "6" output "$monitor1"
      workspace "7" output "$monitor1"
      workspace "8" output "$monitor1"
      workspace "9" output "$monitor1"
      workspace "10" output "$monitor1"
    '';

    extraSessionCommands = ''
      export NIXOS_OZONE_WL="1"
      export WLR_NO_HARDWARE_CURSORS="1"
      export XDG_CURRENT_DESKTOP="sway"
      export XDG_SESSION_TYPE="wayland"
      export XDG_SESSION_DESKTOP="sway"
      export QT_QPA_PLATFORM="wayland"
    '';
  };
}
