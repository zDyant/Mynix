{
  description = "Nixos config flake";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      submodules = true;
      # hash of the version
      # rev = "1c460e98f870676b15871fe4e5bfeb1a32a3d6d8";
    };

    hyprpanel = {
      url = "github:Jas-SinghFSU/HyprPanel";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      overlay-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          overlay-unstable
          inputs.hyprpanel.overlay
        ];
      };
      lib = nixpkgs.lib;

    in {
      nixosConfigurations = {
        zdyant = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs pkgs; };
          modules = [
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable ]; })
            ./modules/nixos/configuration.nix
            inputs.hyprland.nixosModules.default
            home-manager.nixosModules.home-manager {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.zdyant = import ./modules/home/home.nix;
                home-manager.extraSpecialArgs = { inherit inputs ; };
            }
        ];
      };
    };
  };
}
