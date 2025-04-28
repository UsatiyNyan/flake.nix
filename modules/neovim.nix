{ lib, config, pkgs, ... }:

{
  options.myPrograms.neovim.enable = lib.mkEnableOption "Enable neovim module";

  config = lib.mkIf config.myPrograms.neovim.enable {
    programs.neovim = {
      enable = true;

      viAlias = true;
      vimAlias = true;
    };
  };
}
