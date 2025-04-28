{ lib, config, pkgs, inputs, ... }:

{
  options.myPrograms.neovim.enable = lib.mkEnableOption "Enable neovim module";

  config = lib.mkIf config.myPrograms.neovim.enable {
    programs.neovim = {
      enable = true;

      # TODO: setup plugins from here?
    };
  };
}
