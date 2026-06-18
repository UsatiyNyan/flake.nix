{
  description = "OS setup";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
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

    private-hosts = {
      url = "git+ssh://git@github.com/UsatiyNyan/private-hosts.nix?ref=main";
      flake = false;
    };

    l4y3r = {
      url = "git+https://codeberg.org/us4tiyny4n/14y3r.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    private-hosts,
    l4y3r,
    ...
  } @ inputs: let
    user = "us4tiyny4n";

    my = {
      lib = import ./lib;
      configuration = ./configuration;
      optionalConfiguration = import ./optional-configuration;
      modules = import ./modules;
    };

    privateHosts = import "${private-hosts}/hosts.nix";

    hosts =
      [
        rec {
          hostName = "new-moon";
          configPath = ./hosts/${hostName};
          system = "x86_64-linux";
          description = "laptop";
        }
        rec {
          hostName = "lunar-eclipse";
          configPath = ./hosts/${hostName};
          system = "x86_64-linux";
          description = "coputer";
        }
        rec {
          hostName = "waxing-crescent";
          configPath = ./hosts/${hostName};
          system = "aarch64-linux";
          description = "raspberry-pi";
        }
      ]
      ++ privateHosts;

    makeSystem = {
      hostName,
      configPath,
      system,
      ...
    }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit system inputs user hostName my;};
        modules = ["${configPath}/configuration.nix"];
      };

    makeHomeConfiguration = {
      configPath,
      system,
      ...
    }:
      home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = {
          inherit system inputs user my;
          pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
        };
        modules = [
          my.modules.dot.home
          "${configPath}/home.nix"
        ];
      };
  in {
    nixosConfigurations =
      nixpkgs.lib.foldl'
      (accConfigs: {hostName, ...} @ hostArgs:
        accConfigs // {"${hostName}" = makeSystem hostArgs;})
      {}
      hosts;

    homeConfigurations =
      nixpkgs.lib.foldl'
      (accConfigs: {hostName, ...} @ hostArgs:
        accConfigs // {"${user}@${hostName}" = makeHomeConfiguration hostArgs;})
      {}
      hosts;

    devShells = l4y3r.lib.forAllSystems (system: {
      default = l4y3r.lib.extendShell {
        inherit system;
        alias = "14nd5c4p3";
        base = "nix";
      };
    });
  };
}
