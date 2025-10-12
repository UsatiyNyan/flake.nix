{nixpkgs, ...} @ inputs: let
  systems = [
    "x86_64-linux"
    "aarch64-linux"
  ];

  modules = {
    "wayland_cpp" = import ./wayland_cpp.nix;
  };

  _modules = system: let
    pkgs = nixpkgs.legacyPackages.${system};
  in
    nixpkgs.lib.mapAttrs (name: module: pkgs.mkShell (module {inherit inputs pkgs;}))
    modules;
in
  builtins.listToAttrs (map (system: {
      name = system;
      value = _modules system;
    })
    systems)
