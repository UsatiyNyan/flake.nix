{
  description = "A very basic flake";

  inputs = {
    unstable-nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
  };

  outputs = { nixpkgs, unstable-nixpkgs, ... } @ inputs:
  let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    unstable-pkgs = unstable-nixpkgs.legacyPackages.x86_64-linux;
  in
  {
    packages.x86_64-linux.default = pkgs.zsh;

    devShells.x86_64-linux.default = pkgs.mkShell {
      buildInputs = [
        pkgs.neovim
        pkgs.vim
      ];
    };
  };
}
