{
  pkgs,
  ...
}: {
  programs.dconf.enable = true;

  environment = {
    # TODO: systemPackages = with pkgs; [polkit_gnome];
    systemPackages = with pkgs; [hyprpolkitagent];
  };

  security.pam.services.swaylock = {};
}
