{
  description = "OS setup";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... } @ inputs:
  {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; }; # same as inputs = inputs
      modules = [
        ./configuration.nix
	home-manager.nixosModules.home-manager
      ];
    };
  };
}
