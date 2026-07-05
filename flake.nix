{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?rev=7d5d19274b9f6f7498f7af01063f3b3def9bd0fc";
    home-manager = {
      url = "github:nix-community/home-manager?rev=b885baad531fa3d3beae2ba9a0712d22974d8016";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix?rev=9cabea6f5973ec01f60080ea50f54f8f6d74dc95";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix?rev=718c14e8ecba215a65ff955c187fadb9732ddd01";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR?rev=e714624b7c423dfa66a63751ae425350d56a5d4b";
    };
    git-hooks = {
      url = "github:cachix/git-hooks.nix?rev=bca82caa46d5ec0f5d422c61fb1e30bc51313cbe";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    play = {
      url = "github:tophc7/play.nix?rev=fec1003647b457a82a166f7251cd2b1aba1a8f84";
    };
    nixcord = {
      url = "github:kaylorben/nixcord?rev=35f2aa7b56b2e546273307ac2d0fa357ca4c62c3";
    };
    betterfox = {
      url = "github:yokoffing/Betterfox?rev=8e415d1633f10fe0192d9c938e4ca2628eeec9f9";
      flake = false;
    };
    userstyles = {
      url = "github:knoopx/userContent.css?rev=c2590a73fb89b8cf4b82c991d00a6256333732d2";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts?rev=17c9d6cdfc60c64f4ee8d306f9bc0b4ccb51481e";
    };
    mix-nix = {
      url = "github:tophc7/mix.nix?rev=ccb310fdbf1547fd35a472eb9ceb21a9d5f890b4";
    };
    bonk = {
      url = "github:tophc7/bonk?rev=737bf81523ffd311fbd308938463679a793d1e22";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    affinity-nix = {
      url = "github:mrshmllow/affinity-nix?rev=eb5fb72efc11e77e34404a206d978ca8aa131b71";
    };
    disko = {
      url = "github:nix-community/disko?rev=ff8702b4de27f72b4c78573dfb89ec74e36abdf1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {...} @ inputs: let
    # INFO: Extend nixpkgs lib with mix.nix utilities BEFORE entering flake-parts
    # This gives us lib.fs.*, lib.hosts.*, lib.desktop.*, etc.
    lib = inputs.mix-nix.lib;
  in
    inputs.flake-parts.lib.mkFlake
    {
      inherit inputs;
      specialArgs = {inherit lib;};
    }
    {
      systems = ["x86_64-linux"];
      imports = with inputs; [
        mix-nix.flakeModules.default
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

        formatter = lib.mkForce inputs.nixpkgs.legacyPackages.${system}.alejandra;
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

      flake.overlays = import ./overlays {inherit lib inputs;};
      mix = {
        coreModules = with inputs; [
          stylix.nixosModules.stylix
          nur.modules.nixos.default
          bonk.nixosModules.default
          ./modules/hosts/core
        ];
        coreHomeModules = [./modules/home/core];
        hostsDir = ./hosts;
        hostsHomeDir = ./home/hosts;
        usersHomeDir = ./home/users;
        secrets = {
          file = ./secrets.nix;
          gitattributes = ./.gitattributes;
        };

        specialArgs = let
          flakeRoot = ./.;
        in {
          inherit flakeRoot;
        };

        users.zdyant = {
          name = "zdyant";
          uid = 1000;
          shell = inputs.nixpkgs.legacyPackages.x86_64-linux.nushell;
          extraGroups = [
            "adbusers"
            "audio"
            "docker"
            "gamemode"
            "git"
            "i2c"
            "input"
            "libvirtd"
            "networkmanager"
            "video"
            "wheel"
          ];
        };
        hosts.gaia.user = "zdyant";
        hosts.hephaestus = {
          user = "zdyant";
          isServer = true;
          isMinimal = true;
        };
      };
    };
}
