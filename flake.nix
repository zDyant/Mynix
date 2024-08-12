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

    spicetify-nix = {
      url = "github:A1ca7raz/spicetify-nix";
      # url = "github:the-argus/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";

  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, hyprland, spicetify-nix, hyprpanel, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          hyprpanel.overlay.${system}
        ];
      };
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;

    in {
      nixosConfigurations = {
        zdyant = lib.nixosSystem rec {
          inherit system;
          specialArgs = { inherit self hyprland pkgs pkgs-unstable spicetify-nix hyprpanel; };
          modules = [
            ./modules/nixos/configuration.nix
            hyprland.nixosModules.default
            home-manager.nixosModules.home-manager {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.zdyant = import ./modules/home/home.nix;
                home-manager.extraSpecialArgs = specialArgs;
            }
        ];
      };
    };
  };
}
