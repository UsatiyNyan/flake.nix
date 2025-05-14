{
  pkgs,
  user,
  ...
}: {
  services = {
    udisks2 = {
      enable = true;
      mountOnMedia = true;
    };
    gvfs.enable = true;
  };

  security.polkit.enable = true;

  users.users.${user}.extraGroups = ["plugdev"];

  environment.systemPackages = with pkgs; [nautilus];
}
