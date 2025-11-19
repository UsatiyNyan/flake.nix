{pkgs, ...}: {
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [
    xorg.xinit
  ];
  services = {
    seatd.enable = true;
    xserver = {
      enable = true;
      xkb = {
        layout = "us,ru";
        variant = "";
        options = "grp:win_space_toggle";
      };
      displayManager.startx.enable = true;
    };
  };
}
