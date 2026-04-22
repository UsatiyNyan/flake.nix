{
  user,
  inputs,
  lib,
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
    "go" = import ./go.nix;
    "erlang" = import ./erlang.nix;
    "nix" = import ./nix.nix;
    "rust" = import ./rust.nix;
    "cpp-clang" = import ./cpp.clang.nix;
    "cpp-clang-wayland" = import ./cpp.clang.wayland.nix;
    "zig" = import ./zig.nix;
    "typst" = import ./typst.nix;
  };

  # Create args for a specific system
  _mkArgs = system:
    args
    // {
      config.xdg.cacheHome = "/home/${user}/.cache";
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
      inherit system;
    };

  # Helper to create scripts derivation
  _mkScripts = pkgs: {name, src}:
    pkgs.stdenv.mkDerivation {
      inherit name src;
      installPhase = ''
        mkdir -p $out/bin
        cp ${src}/* $out/bin/
        chmod +x $out/bin/*
      '';
    };

  # Extract shell attributes from a module (for composition)
  _extractModuleAttrs = {
    moduleName,
    module,
    _args,
  }: let
    pkgs = _args.pkgs;
    my = _args.my;
  in {
    buildInputs =
      (if builtins.hasAttr "buildInputs" module
       then (module.buildInputs _args)
       else [])
      ++
      (if builtins.hasAttr "scripts" module
       then [(_mkScripts pkgs module.scripts)]
       else []);

    shellHook =
      (if builtins.hasAttr "shellHook" module
       then module.shellHook
       else "")
      + ''
        export MY_NIX_VIA="${if builtins.hasAttr "alias" module then module.alias else moduleName}";
      '';

    nixvimComponent =
      if builtins.hasAttr "nixvim" module
      then module.nixvim
      else null;
  };

  # Build a shell from a single module (original behavior)
  _mkModule = {
    moduleName,
    module,
    _args,
  }: let
    pkgs = _args.pkgs;
    my = _args.my;
    attrs = _extractModuleAttrs {inherit moduleName module _args;};
    nixvimPkg =
      if attrs.nixvimComponent != null
      then [(import my.modules.ide.nixvim-standalone (_args // {additionalComponents = [attrs.nixvimComponent];}))]
      else [];
  in
    pkgs.mkShell {
      buildInputs = attrs.buildInputs ++ nixvimPkg;
      shellHook = attrs.shellHook;
    };

  # Build all shells for a system
  _mkModules = system: let
    _args = _mkArgs system;
  in
    lib.mapAttrs
    (moduleName: module: _mkModule {inherit moduleName module _args;})
    modules;

  # Compose multiple modules into a single shell with extra packages
  mkComposedShell = {
    system,
    bases ? [],
    extraBuildInputs ? [],
    extraShellHook ? "",
    extraNixvimComponents ? [],
  }: let
    _args = _mkArgs system;
    pkgs = _args.pkgs;
    my = _args.my;

    # Extract attributes from all base modules
    baseAttrs = map (baseName:
      _extractModuleAttrs {
        moduleName = baseName;
        module = modules.${baseName};
        inherit _args;
      }
    ) bases;

    # Merge buildInputs from all bases
    mergedBuildInputs = lib.flatten (map (a: a.buildInputs) baseAttrs);

    # Merge shell hooks
    mergedShellHook = lib.concatStringsSep "\n" (map (a: a.shellHook) baseAttrs);

    # Collect all nixvim components
    nixvimComponents =
      (lib.filter (c: c != null) (map (a: a.nixvimComponent) baseAttrs))
      ++ extraNixvimComponents;

    # Build combined nixvim if we have any components
    combinedNixvim =
      if nixvimComponents != []
      then [(import my.modules.ide.nixvim-standalone (_args // {additionalComponents = nixvimComponents;}))]
      else [];

  in pkgs.mkShell {
    buildInputs = mergedBuildInputs ++ combinedNixvim ++ extraBuildInputs;
    shellHook = mergedShellHook + "\n" + extraShellHook;
  };

  # Convenience: extend a single shell
  extendShell = {
    system,
    base,
    extraBuildInputs ? [],
    extraShellHook ? "",
    extraNixvimComponents ? [],
  }: mkComposedShell {
    inherit system extraBuildInputs extraShellHook extraNixvimComponents;
    bases = [base];
  };

in {
  # Ready-made shells per system (backward compatible)
  shells = builtins.listToAttrs (map (system: {
    name = system;
    value = _mkModules system;
  }) systems);

  # Builder functions for composition
  inherit mkComposedShell extendShell;

  # Expose modules for advanced use
  inherit modules;

  # Helper to get args for a system
  getArgs = _mkArgs;
}
