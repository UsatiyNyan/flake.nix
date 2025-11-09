{
  pkgs,
  ...
}: {
  programs.sway = {
    enable = true;
    xwayland.enable = true;
    wrapperFeatures = {
      gtk = true;
    };
    # this is by default:
    # extraPackages = with pkgs; [ brightnessctl foot grim pulseaudio swayidle swaylock wmenu ];
  };

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
      XDG_CURRENT_DESKTOP = "sway";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "sway";
      QT_QPA_PLATFORM = "wayland";
    };

    # TODO: systemPackages = with pkgs; [polkit_gnome];
    systemPackages = with pkgs; [hyprpolkitagent];
  };

  # TODO: swaylock
  security.pam.services.hyprlock = {};
}
