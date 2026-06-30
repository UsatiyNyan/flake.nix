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
      default = "${config.home.homeDirectory}/Pictures/wallpaper.jpg";
      description = "Default wallpaper path (applied to all monitors)";
    };
  };

  config = {
    home = {
      packages = with pkgs; [hyprpaper];
      file.".config/hypr/hyprpaper.conf".text = ''
        wallpaper {
            monitor =
            path = ${cfg.myDefaultWallpaper}
            fit_mode = cover
        }
      '';
    };
  };
}
