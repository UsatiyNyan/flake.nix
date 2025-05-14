{
  inputs,
  pkgs,
  ...
}: let
  whereIsMySddmTheme = pkgs.stdenvNoCC.mkDerivation {
    pname = "where-is-my-sddm-theme";
    version = "0.0";
    dontBuild = true;

    propagatedUserEnvPkgs = [pkgs.libsForQt5.qt5.qtgraphicaleffects];

    src = inputs.where-is-my-sddm-theme;

    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src/where_is_my_sddm_theme_qt5 $out/share/sddm/themes/where-is-my-sddm-theme
    '';
  };
in {
  environment.systemPackages = [whereIsMySddmTheme];
  services.displayManager.sddm = {
    enable = true;
    theme = "where-is-my-sddm-theme";
  };
}
