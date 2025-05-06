{pkgs, ...}:
{
  home.packages = with pkgs; [
    wev # to know which events are which keys
  ];

  wayland.windowManager.hyprland.settings = {
    input = {
      kb_layout = "us,ru";
      kb_variant = "";
      kb_options = "grp:win_space_toggle";
    };

    bind = [
      "$mainMod, T, exec, $terminal"
      "$mainMod, SLASH, exec, $appLauncher"
      "$mainMod, F, exec, $fileManager"

      "$mainMod, Q, killactive"
      "$mainMod SHIFT, ESCAPE, exit"
      "$mainMod, ESCAPE, exec, loginctl lock-session"
    ];

    bindel = [
      ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
    ];
  };
}
