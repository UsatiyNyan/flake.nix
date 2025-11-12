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
    grim
    slurp
    wf-recorder
    swaybg # duplicate
  ];

  home.sessionVariables = {
    SWAYSHOT_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
  };

  wayland.windowManager.sway = {
    enable = true;

    extraConfig = ''
      set $terminal alacritty -e my-tmux-new
      set $terminalTmux alacritty -e my-tmux-attach
      set $screenshotDir ${config.xdg.userDirs.pictures}/Screenshots
    '';

    config = {
      modifier = "Mod4"; # SUPER key
      terminal = "alacritty -e my-tmux-new";

      startup = [
        {command = "systemctl --user start polkit-gnome-authentication-agent-1";}
        {command = "waybar";}
        {command = "swaybg -i ${config.xdg.userDirs.pictures}/wallpaper.jpg --mode fill";}
        {command = "wl-paste --type text --watch cliphist store";}
        {command = "wl-paste --type image --watch cliphist store";}
      ];

      workspaceOutputAssign = [
        {
          workspace = "1";
          output = "$monitor0";
        }
        {
          workspace = "2";
          output = "$monitor0";
        }
        {
          workspace = "3";
          output = "$monitor0";
        }
        {
          workspace = "4";
          output = "$monitor0";
        }
        {
          workspace = "5";
          output = "$monitor0";
        }
      ];

      gaps = {
        inner = 4;
        outer = 0;
      };

      window = {
        hideEdgeBorders = "smart_no_gaps";
      };
    };
  };
}
