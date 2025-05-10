{pkgs, ...}: {
  home = {
    packages = with pkgs; [hyprpaper];
    file.".config/hypr/hyprpaper.conf".text = let
      wallpaperPath = "$HOME/Pictures/wallpaper.jpg";
    in ''
      preload = ${wallpaperPath}
      wallpaper = , ${wallpaperPath}
    '';
  };
}
