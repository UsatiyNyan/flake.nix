{
  inputs,
  pkgs,
  ...
}: let
  rosePineTheme = pkgs.stdenvNoCC.mkDerivation {
    pname = "sddm-rose-pine-theme";
    version = "1.2";
    dontBuild = true;

    propagatedUserEnvPkgs = [pkgs.libsForQt5.qt5.qtgraphicaleffects];

    src = inputs.sddm-rose-pine;

    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src $out/share/sddm/themes/rose-pine
    '';
  };
in {
  environment.systemPackages = [rosePineTheme];
  services.displayManager.sddm = {
    enable = true;
    theme = "rose-pine";
  };
}
