{pkgs, ...}: {
  home.packages = with pkgs; [
    openvpn
    inetutils
  ];
}
