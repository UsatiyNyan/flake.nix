{
  pkgs,
  my,
  ...
}: {
  imports = with my.modules; [
    lang.rust
    lang.cpp
    lang.haskell

    ide.nixvim
  ];

  # nixpkgs.config.allowUnfree = false;

  # home.packages = with pkgs; [ ];
}
