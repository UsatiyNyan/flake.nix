{
  wayland.windowManager.hyprland.settings = {
    input = {
      kb_layout = "us,ru";
      kb_variant = "";
      kb_options = "grp:win_space_toggle";
    };

    bind = [
      "$mainMod, T, exec, $terminal"
      "$mainMod, slash, exec, $appLauncher"
      "$mainMod, F, exec, $fileManager"

      "$mainMod, Q, killactive"
      "$mainMod, escape, exec, loginctl lock-session"
    ];
  };
}
