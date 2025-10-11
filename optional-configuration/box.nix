{
  user,
  pkgs,
  ...
}: {
  virtualisation.libvirtd.enable = true;
  users.users.${user}.extraGroups = ["libvirtd" "kvm"];
  environment.systemPackages = with pkgs; [
    virt-manager
    qemu
    virtiofsd
  ];
}
