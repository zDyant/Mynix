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

    vicinae.url = "github:vicinaehq/vicinae";
    vicinae-extensions = {
      url = "github:vicinaehq/extensions";
      flake = false;
    };
    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    chaotic.url =
      "github:chaotic-cx/nyx/nyxpkgs-unstable"; # Bleeding edge packages from Chaotic-AUR

    play = {
      url = "github:tophc7/play.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
        chaotic.follows = "chaotic";
      };
    };
    nixcord = { url = "github:kaylorben/nixcord"; };
    dms = { url = "github:AvengeMedia/DankMaterialShell"; };
    textfox = { url = "github:adriankarlen/textfox"; };
    betterfox = {
      url = "github:yokoffing/Betterfox";
      flake = false;
    };
    userstyles.url = "github:knoopx/nix-userstyles";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        #"aarch64-darwin"
      ];
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
    in
    {
      overlays = import ./overlays { inherit inputs; };
      formatter = pkgs.nixfmt-rfc-style;

      # INFO:
      # Run the hooks in a sandbox with `nix flake check`.
      # Read-only filesystem and no internet access.

      checks = forAllSystems (system: import ./checks.nix { inherit inputs system pkgs; });

      # INFO:
      # Enter a development shell with `nix develop -c pre-commit run -a`.`
      # The hooks will be installed automatically.
      devShells = forAllSystems (
        system:
        import ./shell.nix {
          checks = self.checks.${system};
        }
      );

      nixosConfigurations = {
        zdyant = lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./modules/nixos/configuration.nix
            inputs.nur.modules.nixos.default
            inputs.stylix.nixosModules.stylix
            inputs.sops-nix.nixosModules.sops
            inputs.chaotic.nixosModules.default
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.zdyant = import ./modules/home/home.nix;
              home-manager.backupFileExtension = "backup";
              home-manager.extraSpecialArgs = { inherit inputs; };
            }
          ];
        };
      };
    };
}
