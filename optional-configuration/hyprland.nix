{
  inputs,
  pkgs,
  system,
  ...
}: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;

    package = inputs.hyprland.packages."${system}".hyprland;
    portalPackage = inputs.hyprland.packages."${system}".xdg-desktop-portal-hyprland;
  };

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1"; # hint electron apps
      WLR_NO_HARDWARE_CURSORS = "1"; # cursor blinking fix
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "Hyprland";
      QT_QPA_PLATFORM = "wayland";
    };

    systemPackages = with pkgs; [hyprpolkitagent];
  };

  security.pam.services.hyprlock = {};
}
