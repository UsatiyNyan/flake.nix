{pkgs, ...}: {
  services.udisks2 = {
    enable = true;
    mountOnMedia = true;
  };

  environment.systemPackages = with pkgs; [
    kdePackages.dolphin
    kdePackages.qtsvg # thumbnails
    kdePackages.kio-extras # mount
  ];
}
