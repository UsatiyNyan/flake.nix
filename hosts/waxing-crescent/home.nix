{
  pkgs,
  my,
  ...
}: {
  imports = with my.modules; [
    ide.nixvim
  ];
  home.sessionVariables.EDITOR = "nvim";

  # nixpkgs.config.allowUnfree = false;

  # home.packages = with pkgs; [ ];
}
