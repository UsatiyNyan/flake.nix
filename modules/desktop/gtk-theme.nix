{pkgs, ...}: {
  gtk = {
    enable = true;
    theme = {
      name = "rose-pine";
      package = pkgs.rose-pine-gtk-theme;
    };
    iconTheme = {
      name = "rose-pine";
      package = pkgs.rose-pine-icon-theme;
    };
    font = {
      name = "Iosevka Nerd Font";
      size = 16;
    };
  };
}
