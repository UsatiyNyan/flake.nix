{
  pkgs,
  my,
  ...
}: {
  imports = with my.modules; [
    lang.rust
    lang.cpp

    ide.nixvim
  ];
  home.sessionVariables.EDITOR = "nvim";

  # nixpkgs.config.allowUnfree = false;

  # home.packages = with pkgs; [ ];
}
