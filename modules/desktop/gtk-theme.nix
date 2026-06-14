{pkgs, ...}: let
  theme = {
    name = "rose-pine";
    package = pkgs.rose-pine-gtk-theme;
  };
  iconTheme = {
    name = "rose-pine";
    package = pkgs.rose-pine-icon-theme;
  };
  font = {
    name = "Gothic A1";
    size = 14;
  };
in {
  gtk = {
    enable = true;
    inherit theme iconTheme font;
    gtk2 = {
      enable = true;
      inherit theme iconTheme font;
    };
    gtk3 = {
      enable = true;
      inherit theme iconTheme font;
    };
    gtk4 = {
      enable = true;
      inherit theme iconTheme font;
    };
  };
}
