{pkgs, ...}: {
  home.pointerCursor = {
    name = "BreezeX-RosePine-Linux";
    size = 24;
    package = pkgs.rose-pine-cursor;
    gtk.enable = true;
    x11 = {
      enable = true;
      defaultCursor = "left_ptr";
    };
  };

  wayland.windowManager.sway = {
    enable = true;

    extraConfig = ''
      seat * hide_cursor when-typing disable
      seat * hide_cursor 5000
    '';

    extraSessionCommands = ''
      export XCURSOR_THEME="BreezeX-RosePine-Linux"
      export XCURSOR_SIZE="24"
    '';
  };
}
