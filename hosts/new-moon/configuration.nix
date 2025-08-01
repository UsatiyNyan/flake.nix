# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  pkgs,
  my,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    my.configuration

    my.optionalConfiguration.boot
    my.optionalConfiguration.sddm
    my.optionalConfiguration.gnome-keyring
    my.optionalConfiguration.hyprland
    my.optionalConfiguration.nautilus
    my.optionalConfiguration.vial
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [pkgs.home-manager];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  services.displayManager = {
    defaultSession = "hyprland";
    sddm.wayland.enable = true;
  };

  security.pam.services.sddm.enableGnomeKeyring = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
}
