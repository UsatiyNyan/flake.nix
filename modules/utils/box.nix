{pkgs, ...}: {
  home.packages = with pkgs; [
    openvpn
    inetutils
    mullvad-vpn
  ];
}
