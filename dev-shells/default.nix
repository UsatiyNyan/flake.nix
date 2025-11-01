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
    "cpp-clang" = import ./cpp.clang.nix;
    "cpp-clang-wayland" = import ./cpp.clang.wayland.nix;
  };

  _mkModule = {
    moduleName,
    module,
    _args,
  }: let
    pkgs = _args.pkgs;
    my = _args.my;
    mkScripts = {
      name,
      src,
    }:
      pkgs.stdenv.mkDerivation {
        inherit name src;
        installPhase = ''
          mkdir -p $out/bin
          cp ${src}/* $out/bin/
          chmod +x $out/bin/*
        '';
      };
  in
    pkgs.mkShell
    (let
      _buildInputs =
        if builtins.hasAttr "buildInputs" module
        then (module.buildInputs _args)
        else [];
      _nixvim =
        if builtins.hasAttr "nixvim" module
        then [(import my.modules.ide.nixvim-standalone (_args // {additionalComponents = [module.nixvim];}))]
        else [];
      _scripts =
        if builtins.hasAttr "scripts" module
        then [(mkScripts module.scripts)]
        else [];
      _shellHook =
        if builtins.hasAttr "shellHook" module
        then module.shellHook
        else "";
      _moduleAlias =
        if builtins.hasAttr "alias" module
        then module.alias
        else moduleName;
    in {
      buildInputs = _buildInputs ++ _nixvim ++ _scripts;
      shellHook = ''
        ${_shellHook}
        export MY_NIX_VIA="${_moduleAlias}";
      '';
    });

  _mkModules = system: let
    _args =
      args
      // {
        config.xdg.cacheHome = "/home/${user}/.cache";
        pkgs = inputs.nixpkgs.legacyPackages.${system};
        inherit system;
      };
  in
    inputs.nixpkgs.lib.mapAttrs
    (moduleName: module: _mkModule {inherit moduleName module _args;})
    modules;
in
  builtins.listToAttrs (map (system: {
      name = system;
      value = _mkModules system;
    })
    systems)
