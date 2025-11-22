{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    wev # still useful for keycode debugging
    brightnessctl

    # screen capture
    grim
    slurp
    jq
    hyprpicker
    woomer

    (pkgs.writeShellScriptBin "my-grim-window" ''
      #!/bin/sh

      jq_cmd=".. | select(.type?) | select(.focused).rect | \"\(.x),\(.y) \(.width)x\(.height)\""
      rect="$(swaymsg -t get_tree | jq -j "$jq_cmd")"

      grim -g "$rect" "$@"
    '')
  ];

  wayland.windowManager.sway = {
    extraSessionCommands = ''
      export GRIM_DEFAULT_DIR="${config.xdg.userDirs.pictures}/Screenshots"
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
        "*" = {
          drag_lock = "disabled";
        };
      };

      bindkeysToCode = true;

      keybindings = let
        wrap = x: "exec sh -c \"${x}\"";
        wrapClip = x: wrap "${x} | wl-copy";
        screenshotArea = ''grim -g $(slurp)'';
        screenshotWindow = "my-grim-window";
        screenshotOutput = ''grim -o $(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')'';
        focusToWorkspace = x: "workspace number ${x}";
        containerToWorkspace = x: "move container to workspace number ${x}";
        focusAndContainerToWorkspace = x: let
          ctw = containerToWorkspace x;
          ftw = focusToWorkspace x;
        in "${ctw}; ${ftw}";
      in {
        "$mod+Shift+t" = "exec $terminal";
        "$mod+t" = "exec $terminalTmux";
        "$mod+slash" = "exec $appLauncher";
        "$mod+f" = "exec $fileManager";
        "$mod+Shift+V" = wrap "cliphist list | $picker | cliphist decode | wl-copy";

        "$mod+z" = wrap "woomer";
        "$mod+c" = wrapClip "hyprpicker";
        "Print" = wrap screenshotArea;
        "$mod+Print" = wrap screenshotWindow;
        "Shift+Print" = wrap screenshotOutput;
        "Ctrl+Print" = wrapClip "${screenshotArea} -";
        "Ctrl+$mod+Print" = wrapClip "${screenshotWindow} -";
        "Ctrl+Shift+Print" = wrapClip "${screenshotOutput} -";

        "$mod+q" = "kill";
        "$mod+Shift+Escape" = "exit";
        "$mod+Escape" = "exec loginctl lock-session";

        "$mod+h" = "focus left";
        "$mod+j" = "focus down";
        "$mod+k" = "focus up";
        "$mod+l" = "focus right";

        "$mod+1" = focusToWorkspace "1";
        "$mod+2" = focusToWorkspace "2";
        "$mod+3" = focusToWorkspace "3";
        "$mod+4" = focusToWorkspace "4";
        "$mod+5" = focusToWorkspace "5";
        "$mod+6" = focusToWorkspace "6";
        "$mod+7" = focusToWorkspace "7";
        "$mod+8" = focusToWorkspace "8";
        "$mod+9" = focusToWorkspace "9";
        "$mod+0" = focusToWorkspace "10";

        "$mod+Shift+1" = focusAndContainerToWorkspace "1";
        "$mod+Shift+2" = focusAndContainerToWorkspace "2";
        "$mod+Shift+3" = focusAndContainerToWorkspace "3";
        "$mod+Shift+4" = focusAndContainerToWorkspace "4";
        "$mod+Shift+5" = focusAndContainerToWorkspace "5";
        "$mod+Shift+6" = focusAndContainerToWorkspace "6";
        "$mod+Shift+7" = focusAndContainerToWorkspace "7";
        "$mod+Shift+8" = focusAndContainerToWorkspace "8";
        "$mod+Shift+9" = focusAndContainerToWorkspace "9";
        "$mod+Shift+0" = focusAndContainerToWorkspace "10";

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
