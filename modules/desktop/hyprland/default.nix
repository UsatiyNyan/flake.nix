{
  imports = [
    ./binds.nix
    ./bar.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mainMod" = "SUPER";
      "$terminal" = "alacritty";

      "input:touchpad" = {
        natural_scroll = "true";
      };
    };
  };
}
