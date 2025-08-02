# hyprcursor doesn't really work with gtk apps :(
{pkgs, ...}: {
  home.pointerCursor = {
    name = "BreezeX-RosePine-Linux";
    size = 24;
    package = pkgs.rose-pine-cursor;
    gtk.enable = true;
    x11 = {
      enable = true;
      defaultCursor = "X_cursor";
    };
  };

  wayland.windowManager.hyprland.settings = {
    env = [
      "XCURSOR_THEME,BreezeX-RosePine-Linux"
      "XCURSOR_SIZE,24"
    ];
    cursor.inactive_timeout = 5;
  };
}
