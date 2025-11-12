{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    wev # still useful for keycode debugging
    brightnessctl
  ];

  wayland.windowManager.sway = {
    enable = true;

    extraConfig = ''
      set $terminal alacritty -e my-tmux-new
      set $terminalTmux alacritty -e my-tmux-attach
    '';

    config = {
      input = {
        "type:keyboard" = {
          xkb_layout = "us,ru";
          xkb_options = "grp:win_space_toggle";
        };
        "type:touchpad" = {
          natural_scroll = "enabled";
        };
      };

      # Keybindings
      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
      in {
        # Launchers
        "${modifier}+Shift+t" = "exec $terminal";
        "${modifier}+t" = "exec $terminalTmux";
        "${modifier}+slash" = "exec $appLauncher";
        "${modifier}+f" = "exec $fileManager";
        "${modifier}+c" = "exec hyprpicker -a"; # or "grim -g \"$(slurp)\" - | wl-copy" for Sway-native
        "Print" = "exec grim -g \"$(slurp)\" - | wl-copy";
        "${modifier}+Print" = "exec grim -o $(swaymsg -t get_outputs | jq -r '.[0].name') - | wl-copy";
        "${modifier}+Shift+Print" = "exec grim - | wl-copy";

        # System
        "${modifier}+q" = "kill";
        "${modifier}+Shift+Escape" = "exit";
        "${modifier}+Escape" = "exec loginctl lock-session";

        # Focus movement
        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";

        # Workspace switching (1–10)
        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";
        "${modifier}+0" = "workspace number 10";

        # Move focused window to workspace
        "${modifier}+Shift+1" = "move container to workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5";
        "${modifier}+Shift+6" = "move container to workspace number 6";
        "${modifier}+Shift+7" = "move container to workspace number 7";
        "${modifier}+Shift+8" = "move container to workspace number 8";
        "${modifier}+Shift+9" = "move container to workspace number 9";
        "${modifier}+Shift+0" = "move container to workspace number 10";

        # Scratchpad (Sway built-in)
        "${modifier}+s" = "scratchpad show";
        "${modifier}+Shift+s" = "move container to scratchpad";

        # Cycle workspaces
        "${modifier}+Ctrl+h" = "workspace prev_on_output";
        "${modifier}+Ctrl+l" = "workspace next_on_output";
        "${modifier}+Shift+h" = "move container to workspace prev_on_output";
        "${modifier}+Shift+l" = "move container to workspace next_on_output";

        # Brightness / Volume
        "XF86MonBrightnessDown" = "exec brightnessctl set 10%-";
        "XF86MonBrightnessUp" = "exec brightnessctl set +10%";
        "XF86AudioRaiseVolume" = "exec wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+";
        "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "XF86AudioMicMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
      };

      # # Mouse bindings (drag/resize)
      # mousebindings = {
      #   "${modifier}+button1" = "move";
      #   "${modifier}+button3" = "resize";
      # };
    };
  };
}
