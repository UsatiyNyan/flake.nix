{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.hyprpaper;
in {
  options.hyprpaper = {
    myDefaultWallpaper = lib.mkOption {
      type = lib.types.str;
      default = "$HOME/Pictures/wallpaper.jpg";
      description = "Default wallpaper path";
    };
    myExtraPreload = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Additional wallpapers to preload";
    };
  };

  config = {
    home = {
      packages = with pkgs; [hyprpaper];
      file.".config/hypr/hyprpaper.conf".text = let
        allPreloads = [cfg.myDefaultWallpaper] ++ cfg.myExtraPreload;
        preloadLines = lib.concatMapStringsSep "\n" (p: "preload = ${p}") allPreloads;
      in ''
        ${preloadLines}
        wallpaper = , ${cfg.myDefaultWallpaper}
      '';
    };
  };
}
