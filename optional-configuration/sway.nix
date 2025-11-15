{
  pkgs,
  ...
}: {
  programs.dconf.enable = true;
  security.pam.services.swaylock = {};
  environment.systemPackages = with pkgs; [hyprpolkitagent]; # leftover
}
