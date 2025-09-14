{
  pkgs,
  my,
  inputs,
  system,
  lib,
  user,
  config,
  ...
}: {
  imports = [
    ./minecraft.nix
  ];

  home.packages = [
    (import my.modules.ide.nixvim-standalone {inherit pkgs inputs my lib system user config;})
  ];
  home.sessionVariables.EDITOR = "nvim";

  # nixpkgs.config.allowUnfree = false;

  # home.packages = with pkgs; [ ];
}
