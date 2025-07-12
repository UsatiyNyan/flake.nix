{
  pkgs,
  my,
  ...
}: {
  imports = with my.modules; [
    lang.rust
    lang.cpp
    lang.haskell
  ];

  # nixpkgs.config.allowUnfree = false;

  # home.packages = with pkgs; [ ];
}
