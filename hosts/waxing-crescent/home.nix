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
    (inputs.l4y3r.lib.nixvim {inherit pkgs inputs my lib system user config;})
  ];
  home.sessionVariables.EDITOR = "nvim";

  # nixpkgs.config.allowUnfree = false;

  # home.packages = with pkgs; [ ];
}
