{
  pkgs,
  my,
  ...
}: {
  imports = with my.modules; [
    lang.rust
  ];

  # nixpkgs.config.allowUnfree = false;

  # home.packages = with pkgs; [ ];
}
