{inputs, ...}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./plugins.nix
    ./settings.nix
  ];

  programs.nixvim.enable = true;
}
