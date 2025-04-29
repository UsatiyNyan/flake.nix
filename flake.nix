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

    myConfiguration = ./configuration;
    myModules = {
        dot = {
          home = ./modules/dot/home.nix;
        };
        ide = {
          neovim = ./modules/ide/neovim.nix;
        };
        de = {
          hyprland = ./modules/de/hyprland.nix;
        };
    };

    hosts = [
      { hostName = "new-moon"; description = "laptop"; }
      # { hostName = "waxing-crescent"; description = "raspberry-pi"; }
    ];

    makeSystem = { hostName }: nixpkgs.lib.nixosSystem {
      inherit system; # same as system = system
      specialArgs = {
        inherit inputs user hostName myConfiguration myModules;
	  };
      modules = [ ./hosts/${hostName}/configuration.nix ];
    };
  in
  {
    nixosConfigurations = nixpkgs.lib.foldl' 
      (accConfigs: aHost:
       accConfigs // { "${aHost.hostName}" = makeSystem { hostName = aHost.hostName; }; })
      {} hosts;

    homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit inputs user myModules;
      };
      modules = [ myModules.dot.home ];
    };
  };
}
