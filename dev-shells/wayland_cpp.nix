{pkgs, ...}: {
  buildInputs = with pkgs; [
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
  ];
}
