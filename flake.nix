{
  description = "OS setup";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.11";
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

    sddm-rose-pine = {
      url = "github:lwndhrst/sddm-rose-pine";
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
    system = "x86_64-linux";
    user = "us4tiyny4n";

    my = {
      configuration = ./configuration;
      optionalConfiguration = import ./optional-configuration;
      modules = import ./modules;
    };

    hosts = [
      {
        hostName = "new-moon";
        description = "laptop";
      }
      # { hostName = "waxing-crescent"; description = "raspberry-pi"; }
    ];

    makeSystem = {hostName}:
      nixpkgs.lib.nixosSystem {
        inherit system; # same as system = system
        specialArgs = {inherit inputs user hostName my;};
        modules = [./hosts/${hostName}/configuration.nix];
      };

    makeHomeConfiguration = {hostName}:
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
      (accConfigs: {hostName, ...}:
        accConfigs // {"${hostName}" = makeSystem {inherit hostName;};})
      {}
      hosts;

    homeConfigurations =
      nixpkgs.lib.foldl'
      (accConfigs: {hostName, ...}:
        accConfigs // {"${user}@${hostName}" = makeHomeConfiguration {inherit hostName;};})
      {}
      hosts;
  };
}
