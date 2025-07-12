{system, ...}: {
  # Bootloader for desktop
  boot.loader = if system == "x86_64-linux" then {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  } else {};
}
