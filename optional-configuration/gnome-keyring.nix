{pkgs, ...}: {
  services.gnome.gnome-keyring.enable = true;
  environment.systemPackages = with pkgs; [libsecret];
  environment.variables.XDG_RUNTIME_DIR = "/run/user/$UID"; # set the runtime directory
}
