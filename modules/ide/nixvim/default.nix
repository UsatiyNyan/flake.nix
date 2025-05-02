{ inputs, ... }:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./settings
    ./plugins
  ];

  home.sessionVariables.EDITOR = "nvim";

  programs.nixvim.enable = true;
}
