{pkgs, ...}: {
  xdg.portal = {
    enable = true;
    config = {
      common = {
        default = ["wlr" "gtk"];
        "org.freedesktop.impl.portal.FileChooser" = ["gtk"];
      };
    };
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };
}
