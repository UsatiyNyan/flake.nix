{inputs, ...}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./plugins.nix
    ./settings.nix
  ];

  home.sessionVariables.EDITOR = "nvim";

  programs.nixvim.enable = true;
}
