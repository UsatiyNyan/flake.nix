{
  appimageTools,
  fetchurl,
  stdenv,
}: let
  pname = "helium";
  version = "0.13.3.1";

  systemMapping = {
    x86_64-linux = "x86_64";
    aarch64-linux = "arm64";
  };

  aSystem = systemMapping.${stdenv.hostPlatform.system};

  src = fetchurl {
    url = "https://github.com/imputnet/helium-linux/releases/download/${version}/helium-${version}-${aSystem}.AppImage";
    hash = "sha256-RS+Sn42V+HjCw41N1zayMVIqlgH+i2B2IdVJwBPmw00=";
  };

  appimageContents = appimageTools.extractType2 {inherit pname version src;};
in
  appimageTools.wrapType2 {
    inherit pname version src;

    extraInstallCommands = ''
      install -Dm444 ${appimageContents}/helium.desktop -t $out/share/applications
      install -Dm444 ${appimageContents}/helium.png -t $out/share/icons/hicolor/512x512/apps
    '';
  }
