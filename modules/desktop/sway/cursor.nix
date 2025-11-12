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

  home.sessionVariables = {
    "XCURSOR_THEME" = "BreezeX-RosePine-Linux";
    "XCURSOR_SIZE" = "24";
  };

  wayland.windowManager.sway = {
    enable = true;

    config = {
      seat."*" = {
        hide_cursor = "when-typing enable";
        # idle_warp = "no";
      };
    };
    # extraConfig = ''
    #   seat * hide_cursor 5
    # '';
  };
}
