let
  base = import ./cpp.clang.nix;
in {
  inherit (base) nixvim scripts shellHook;
  buildInputs = {pkgs, ...} @ args:
    (base.buildInputs args)
    ++ (with pkgs; [
      extra-cmake-modules

      # graphics
      wayland
      wayland-scanner
      wayland-protocols
      libxkbcommon
      libffi
      libglvnd

      # audio
      alsa-lib
      libpulseaudio
      pipewire
    ]);
}
