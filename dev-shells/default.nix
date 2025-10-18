{
  user,
  inputs,
  ...
} @ args: let
  systems = [
    "x86_64-linux"
    "aarch64-linux"
  ];

  modules = {
    "haskell" = import ./haskell.nix;
    "lua" = import ./lua.nix;
    "js" = import ./js.nix;
    "erlang" = import ./erlang.nix;
    "nix" = import ./nix.nix;
    "rust" = import ./rust.nix;
    "cpp.clang" = import ./cpp.clang.nix;
    "cpp.clang.wayland" = import ./cpp.clang.wayland.nix;
  };

  _modules = system: let
    pkgs = inputs.nixpkgs.legacyPackages.${system};
    _args =
      args
      // {
        config.xdg.cacheHome = "/home/${user}/.cache";
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
