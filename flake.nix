{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?rev=c4c3c1898c74d2537346f7716febdb1990bface8";
    home-manager = {
      url = "github:nix-community/home-manager?rev=c58f54c733a7894d84fa2fdff26cc12088c4b78c";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
    };
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    play = {
      url = "github:TophC7/play.nix";
    };
    nixcord = {
      url = "github:kaylorben/nixcord";
    };
    betterfox = {
      url = "github:yokoffing/Betterfox";
      flake = false;
    };
    userstyles = {
      url = "github:knoopx/userContent.css";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };
    mix-nix = {
      url = "github:tophc7/mix.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hister = {
      url = "github:asciimoo/hister";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
    bonk = {
      url = "github:tophc7/bonk";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    audio = {
      url = "github:flashgnash/audio.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emyl-nix = {
      url = "path:/repos/emyl-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixcord.follows = "nixcord";
      inputs.spicetify-nix.follows = "spicetify-nix";
      inputs.userstyles.follows = "userstyles";
    };
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake
    {
      inherit inputs;
      specialArgs = {inherit (inputs.mix-nix) lib;};
    }
    {
      systems = ["x86_64-linux"];
      imports = with inputs; [
        mix-nix.flakeModules.default
        ./mix
      ];

      perSystem = {
        system,
        pkgs,
        ...
      }: {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        formatter = inputs.nixpkgs.lib.mkForce inputs.nixpkgs.legacyPackages.${system}.alejandra;
        # INFO: Run the hooks in a sandbox with `nix flake check`.
        # Read-only filesystem and no internet access.
        checks = import ./checks.nix {inherit inputs system pkgs;};

        # INFO:
        # Enter a development shell with `nix develop -c pre-commit run -a`.`
        # The hooks will be installed automatically.
        devShells = import ./shell.nix {
          inherit pkgs;
          checks = inputs.self.checks.${system};
        };
      };

      flake.overlays = import ./overlays {
        inherit (inputs.mix-nix) lib;
        inherit inputs;
      };
    };
}
