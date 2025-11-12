{pkgs, ...}: {
  home = {
    packages = with pkgs; [swaybg];
    file.".config/swaybg/config".text = let
      wallpaperPath = "$HOME/Pictures/wallpaper.jpg";
    in ''
      output * bg ${wallpaperPath} fill
    '';
  };
}
