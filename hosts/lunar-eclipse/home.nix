{
  pkgs,
  my,
  inputs,
  system,
  lib,
  user,
  config,
  ...
}: let
  monitor0 = "DP-6";
in {
  imports = with my.modules; [
    dot.alacritty
    dot.direnv

    desktop.hyprland
    desktop.rofi
    desktop.mako
    desktop.gtk-theme

    ide.ai

    utils.box
    utils.office
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # TERMINAL
    caligula

    # STYLE
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term

    (import my.modules.ide.nixvim-standalone {inherit pkgs inputs my lib system user config;})
  ];
  home.sessionVariables.EDITOR = "nvim";
  home.sessionVariables.MY_SHELL_HOOK = "set_default";
  home.sessionVariables.MY_INDEX = "3";

  fonts.fontconfig.enable = true;

  wayland.windowManager.hyprland.plugins = [pkgs.hyprlandPlugins.hyprwinwrap];
  wayland.windowManager.hyprland.settings = {
    "$monitor0" = monitor0;

    "$appLauncher" = "rofi -show drun -show-icons";
    "$picker" = "rofi -dmenu";
    "$fileManager" = "nautilus";

    "plugin:hyprwinwrap:title" = "serious-music-visualizer";
  };

  hypridle.enableSuspend = false;

  hyprpaper.myExtraPreload = [
    "$HOME/Pictures/NAVI.jpeg"
    "$HOME/Pictures/CYBERIA.jpeg"
    "$HOME/Pictures/CAFE.jpeg"
  ];

  myShellHookCallbacks = {
    set_default = "pkill -f serious-music-visualizer; pkill mpv; hyprctl hyprpaper wallpaper '${monitor0},~/Pictures/wallpaper.jpg' > /dev/null 2>&1";
    set_navi = "hyprctl hyprpaper wallpaper '${monitor0},~/Pictures/NAVI.jpeg' > /dev/null 2>&1";
    set_cyberia = "mpv --no-video 'https://www.youtube.com/watch?v=IqMLfrs1qm4' --volume=40 > /dev/null 2>&1 & ~/.local/bin/serious-music-visualizer > /dev/null 2>&1 &; hyprctl hyprpaper wallpaper '${monitor0},~/Pictures/CYBERIA.jpeg' > /dev/null 2>&1";
    set_cafe = "hyprctl hyprpaper wallpaper '${monitor0},~/Pictures/CAFE.jpeg' > /dev/null 2>&1";
  };
}
