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
    brightnessctl
    wl-color-picker
    grim
    slurp
    wf-recorder
  ];

  wayland.windowManager.sway = {
    enable = true;

    extraConfigEarly = ''
      set $terminal alacritty -e my-tmux-new
      set $terminalTmux alacritty -e my-tmux-attach
      set $screenshotDir ${config.xdg.userDirs.pictures}/Screenshots
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
      workspaceOutputAssign = [];

      window = {
        hideEdgeBorders = "smart_no_gaps";
        titlebar = false;
      };

      gaps = {
        inner = 4;
        outer = 0;
      };
    };
  };
}
