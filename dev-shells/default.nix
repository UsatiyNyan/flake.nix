{nixpkgs, ...} @ inputs: let
  waylandCpp = import ./wayland_cpp.nix;
in {
  "x86_64-linux" = let
    pkgs = nixpkgs.legacyPackages."x86_64-linux";
  in {
    "wayland_cpp" = pkgs.mkShell (waylandCpp {inherit pkgs;});
  };
  "aarch64-linux" = {
  };
}
