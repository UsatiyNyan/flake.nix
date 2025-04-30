{ lib, config, pkgs, inputs, ... }:

{
  home = {
    sessionVariables.EDITOR = "nvim";

    # TODO: migrate to flakes
    file.".config/nvim" = {
      source = inputs.init-lua;
      target = ".config/nvim";
      recursive = true;
      force = true;
    };
  };

  programs.neovim = {
    enable = true;

    # TODO: setup plugins from here?
  };
}
