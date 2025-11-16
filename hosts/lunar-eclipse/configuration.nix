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
    (import my.optionalConfiguration.greetd {cmd = "sway --unsupported-gpu";})
    my.optionalConfiguration.gnome-keyring
    my.optionalConfiguration.sway
    my.optionalConfiguration.nautilus
    my.optionalConfiguration.vial
    my.optionalConfiguration.box
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

  security.pam.services.greetd.enableGnomeKeyring = true;

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

  boot.loader.timeout = 15;
  boot.loader.systemd-boot = {
    # The device handle of the EFI System Partition (ESP) where the Windows bootloader is
    # located. This is the device handle that the EDK2 UEFI Shell uses to load the
    # bootloader.
    #
    # To find this handle, follow these steps:
    # 1. Set {option}`boot.loader.systemd-boot.edk2-uefi-shell.enable` to `true`
    # 2. Run `nixos-rebuild boot`
    # 3. Reboot and select "EDK2 UEFI Shell" from the systemd-boot menu
    # 4. Run `map -c` to list all consistent device handles
    # 5. For each device handle (for example, `HD0c1`), run `ls HD0c1:\EFI`
    # 6. If the output contains the directory `Microsoft`, you might have found the correct device handle
    # 7. Run `HD0c1:\EFI\Microsoft\Boot\Bootmgfw.efi` to check if Windows boots correctly
    # 8. If it does, this device handle is the one you need (in this example, `HD0c1`)

    windows = {
      "whatever" = {
        title = "more like Shindows";
        efiDeviceHandle = "FS0";
      };
    };
  };
}
