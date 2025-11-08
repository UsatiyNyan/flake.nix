{
  buildInputs = {inputs, system, ...}:
    [
      inputs.nixpkgs-unstable.legacyPackages.${system}.zig
    ];
  nixvim = {inputs, system, ...}: {
    plugins.lsp.servers.zls = {
      enable = true;
      package = inputs.nixpkgs-unstable.legacyPackages.${system}.zls;
    };
  };
}
