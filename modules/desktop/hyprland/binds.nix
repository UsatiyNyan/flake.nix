{pkgs, ...}: {
  home.packages = with pkgs; [
    wev # to know which events are which keys
    woomer
  ];

  wayland.windowManager.hyprland.settings = {
    input = {
      kb_layout = "us,ru";
      kb_variant = "";
      kb_options = "grp:win_space_toggle";

      touchpad.natural_scroll = "true";
    };

    gesture = "3, swipe, workspace";

    bind = [
      "$mainMod SHIFT, T, exec, $terminal"
      "$mainMod, T, exec, $terminalTmux"
      "$mainMod, SLASH, exec, $appLauncher"
      "$mainMod, F, exec, $fileManager"
      "$mainMod SHIFT, V, exec, cliphist list | $picker | cliphist decode | wl-copy"
      "$mainMod, Z, exec, woomer"

      "$mainMod, C, exec, hyprpicker -a"
      ", PRINT, exec, hyprshot -z -m region"
      "$mainMod, PRINT, exec, hyprshot -m window active"
      "$mainMod SHIFT, PRINT, exec, hyprshot -m output"

      "$mainMod, Q, killactive"
      "$mainMod SHIFT, ESCAPE, exit"
      "$mainMod, ESCAPE, exec, loginctl lock-session"

      # Move focus
      "$mainMod, H, movefocus, l"
      "$mainMod, J, movefocus, d"
      "$mainMod, K, movefocus, u"
      "$mainMod, L, movefocus, r"

      # Switch workspaces
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"
      "$mainMod, 0, workspace, 10"

      # Move active window to a workspace
      "$mainMod SHIFT, 1, movetoworkspace, 1"
      "$mainMod SHIFT, 2, movetoworkspace, 2"
      "$mainMod SHIFT, 3, movetoworkspace, 3"
      "$mainMod SHIFT, 4, movetoworkspace, 4"
      "$mainMod SHIFT, 5, movetoworkspace, 5"
      "$mainMod SHIFT, 6, movetoworkspace, 6"
      "$mainMod SHIFT, 7, movetoworkspace, 7"
      "$mainMod SHIFT, 8, movetoworkspace, 8"
      "$mainMod SHIFT, 9, movetoworkspace, 9"
      "$mainMod SHIFT, 0, movetoworkspace, 10"

      "$mainMod, S, togglefloating"

      # Scroll through existing workspaces
      "$mainMod CTRL, H, workspace, e-1"
      "$mainMod CTRL, L, workspace, e+1"
      "$mainMod SHIFT, H, movetoworkspace, e-1"
      "$mainMod SHIFT, L, movetoworkspace, e+1"
    ];

    # Move/resize windows with mainMod + LMB/RMB and dragging
    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

    bindel = [
      ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ",XF86MonBrightnessUp,   exec, brightnessctl s 10%+"
      ",XF86AudioRaiseVolume,  exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume,  exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute,         exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioMicMute,      exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    ];
  };
}
