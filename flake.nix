{
  description = "Nixos config flake";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix/release-25.11";
    nur.url = "github:nix-community/NUR";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vicinae-extensions = {
      url = "github:vicinaehq/extensions";
      flake = false;
    };
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    play = {
      url = "github:tophc7/play.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
      };
    };
    nixcord = { url = "github:kaylorben/nixcord"; };
    dms = {
      url =
        "github:AvengeMedia/DankMaterialShell/?ref=406dc64abab2ef04b27148720be34f43f2246b1f";
    };
    textfox = { url = "github:adriankarlen/textfox"; };
    betterfox = {
      url = "github:yokoffing/Betterfox";
      flake = false;
    };
    userstyles = { url = "github:knoopx/nix-userstyles"; };

    flake-parts.url = "github:hercules-ci/flake-parts";
    mix-nix = {
      url = "github:tophc7/mix.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    bonk = {
      url = "github:tophc7/bonk";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { ... }@inputs:
    let
      # Extend nixpkgs lib with mix.nix utilities BEFORE entering flake-parts
      # This gives us lib.fs.*, lib.hosts.*, lib.desktop.*, etc.
      lib = inputs.mix-nix.lib;
    in inputs.flake-parts.lib.mkFlake {
      inherit inputs;
      specialArgs = { inherit lib; };
    } {
      systems = [ "x86_64-linux" ];
      imports = [ inputs.mix-nix.flakeModules.default ];

      perSystem = { system, pkgs, ... }: {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        # INFO:
        # Run the hooks in a sandbox with `nix flake check`.
        # Read-only filesystem and no internet access.
        checks = import ./checks.nix { inherit inputs system pkgs; };

        # INFO:
        # Enter a development shell with `nix develop -c pre-commit run -a`.`
        # The hooks will be installed automatically.
        devShells.default =
          import ./shell.nix { checks = inputs.self.checks.${system}; };
      };

      flake.overlays = import ./overlays { inherit inputs; };
      mix = {
        coreModules = [
          inputs.stylix.nixosModules.stylix
          inputs.sops-nix.nixosModules.sops
          inputs.nur.modules.nixos.default
          inputs.bonk.nixosModules.default
          ./modules/host/core
        ];
        coreHomeModules = [ ];
        hostsDir = ./hosts;
        hostsHomeDir = ./home/hosts;
        usersHomeDir = ./home/users;

        users.zdyant = {
          name = "zdyant";
          uid = 1000;
          shell = "zsh";
          extraGroups = [ "networkmanager" "wheel" "docker" ];
        };
        hosts.gaia.user = "zdyant";
      };
    };
}
