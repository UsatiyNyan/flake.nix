{
  description = "OS setup";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    alacritty-rose-pine = {
      url = "github:rose-pine/alacritty";
      flake = false;
    };

    where-is-my-sddm-theme = {
      url = "github:stepanzubkov/where-is-my-sddm-theme";
      flake = false;
    };

    init-lua = {
      url = "github:UsatiyNyan/init.lua";
      flake = false;
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    user = "us4tiyny4n";

    my = {
      lib = import ./lib;
      configuration = ./configuration;
      optionalConfiguration = import ./optional-configuration;
      modules = import ./modules;
    };

    hosts = [
      {
        hostName = "new-moon";
        system = "x86_64-linux";
        description = "laptop";
      }
      {
        hostName = "waxing-crescent";
        system = "aarch64-linux";
        description = "raspberry-pi";
      }
    ];

    makeSystem = {
      hostName,
      system,
    }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit system inputs user hostName my;};
        modules = [./hosts/${hostName}/configuration.nix];
      };

    makeHomeConfiguration = {
      hostName,
      system,
    }:
      home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = {inherit inputs user my;};
        modules = [
          my.modules.dot.home
          ./hosts/${hostName}/home.nix
        ];
      };
  in {
    nixosConfigurations =
      nixpkgs.lib.foldl'
      (accConfigs: {
        hostName,
        system,
        ...
      }:
        accConfigs // {"${hostName}" = makeSystem {inherit hostName system;};})
      {}
      hosts;

    homeConfigurations =
      nixpkgs.lib.foldl'
      (accConfigs: {
        hostName,
        system,
        ...
      }:
        accConfigs // {"${user}@${hostName}" = makeHomeConfiguration {inherit hostName system;};})
      {}
      hosts;
  };
}
