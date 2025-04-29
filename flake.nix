{
  description = "OS setup";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    init-lua = {
      url = "github:UsatiyNyan/init.lua";
      flake = false;
    };

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
        url = "github:hyprwm/hyprland-plugins";
        inputs.hyprland.follows = "hyprland";
    };
  };

  outputs = { nixpkgs, home-manager, ... } @ inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    user = "us4tiyny4n";
    hostName = "new-moon";
    myConfiguration = ./configuration;
    myModules = {
        ide = {
          neovim = import ./modules/ide/neovim.nix;
        };
        de = {
          hyprland = import ./modules/de/hyprland.nix;
        };
    };
  in
  {
    nixosConfigurations = {
      ${hostName} = nixpkgs.lib.nixosSystem {
        inherit system; # same as system = system
        specialArgs = {
          inherit inputs user hostName myConfiguration myModules;
	    };
        modules = [
          ./hosts/${hostName}/configuration.nix
        ];
      };
      # raspberrypi = nixpkgs.lib.nixosSystem {
      #   specialArgs = { inherit inputs; };
      #   modules = [
      #     ./hosts/raspberrypi/configuration.nix
      #   ];
      # };
    };
  };
}
