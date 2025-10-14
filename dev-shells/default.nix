{inputs, ...} @args: let
  systems = [
    "x86_64-linux"
    "aarch64-linux"
  ];

  modules = {
    "wayland_cpp" = import ./wayland_cpp.nix;
    "haskell" = import ./haskell.nix;
  };

  _modules = system: let
    pkgs = inputs.nixpkgs.legacyPackages.${system};
    _args = args // {
      config.xdg.cacheHome = "~/.cache";
      inherit system pkgs;
    };
  in
    inputs.nixpkgs.lib.mapAttrs (name: module: pkgs.mkShell (module _args))
    modules;
in
  builtins.listToAttrs (map (system: {
      name = system;
      value = _modules system;
    })
    systems)
