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

      bindkeysToCode = true;

      keybindings = {
        "$mod+Shift+t" = "exec $terminal";
        "$mod+t" = "exec $terminalTmux";
        "$mod+slash" = "exec $appLauncher";
        "$mod+f" = "exec $fileManager";
        "$mod+c" = "exec wl-color-picker -a";
        "Print" = "exec grim -g \"$(slurp)\" - | wl-copy";
        # "$mod+Print" = "";
        # "$mod+Shift+Print" = "";

        "$mod+q" = "kill";
        "$mod+Shift+Escape" = "exit";
        "$mod+Escape" = "exec loginctl lock-session";

        "$mod+h" = "focus left";
        "$mod+j" = "focus down";
        "$mod+k" = "focus up";
        "$mod+l" = "focus right";

        "$mod+1" = "workspace number 1";
        "$mod+2" = "workspace number 2";
        "$mod+3" = "workspace number 3";
        "$mod+4" = "workspace number 4";
        "$mod+5" = "workspace number 5";
        "$mod+6" = "workspace number 6";
        "$mod+7" = "workspace number 7";
        "$mod+8" = "workspace number 8";
        "$mod+9" = "workspace number 9";
        "$mod+0" = "workspace number 10";

        "$mod+Shift+1" = "move container to workspace number 1";
        "$mod+Shift+2" = "move container to workspace number 2";
        "$mod+Shift+3" = "move container to workspace number 3";
        "$mod+Shift+4" = "move container to workspace number 4";
        "$mod+Shift+5" = "move container to workspace number 5";
        "$mod+Shift+6" = "move container to workspace number 6";
        "$mod+Shift+7" = "move container to workspace number 7";
        "$mod+Shift+8" = "move container to workspace number 8";
        "$mod+Shift+9" = "move container to workspace number 9";
        "$mod+Shift+0" = "move container to workspace number 10";

        "$mod+Ctrl+h" = "workspace prev_on_output";
        "$mod+Ctrl+l" = "workspace next_on_output";

        "XF86MonBrightnessDown" = "exec brightnessctl set 10%-";
        "XF86MonBrightnessUp" = "exec brightnessctl set +10%";
        "XF86AudioRaiseVolume" = "exec wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+";
        "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "XF86AudioMicMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
      };
    };
  };
}
