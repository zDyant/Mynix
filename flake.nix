{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?rev=c4e77a7c0c0e7dc25f955d9bd0d51c1c5456dc35";
    home-manager = {
      url = "github:nix-community/home-manager?rev=4b9add8645d5e2b0f7de18f7a442d08fe2bdcc91";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix?rev=e96330757db4c93b10c31b85feb23ffa693f7b2d";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix?rev=abff36bfab11cbdcd0723f41c1b0921e211be6ac";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR?rev=fe370cfa9840c433789b6853673773152efd9f25";
    };
    git-hooks = {
      url = "github:cachix/git-hooks.nix?rev=0d3997c4d3253505f77c9bcea63904bb575da3c5";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    play = {
      url = "github:tophc7/play.nix?rev=fec1003647b457a82a166f7251cd2b1aba1a8f84";
    };
    nixcord = {
      url = "github:kaylorben/nixcord?rev=25816aa65e4f19d72a24a1785f3185b42a93b3c4";
    };
    betterfox = {
      url = "github:yokoffing/Betterfox?rev=067172a4b0dc90e78e5b8b94d9abfe6430c6a7be";
      flake = false;
    };
    userstyles = {
      url = "github:knoopx/userContent.css?rev=19be5f97414b03682511a4ff7449c731b7e4a7b8";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts?rev=31729ca8cbdb4fa927b34e5f4353e6a83f39e993";
    };
    mix-nix = {
      url = "github:tophc7/mix.nix?rev=4877cb1d1ce7b3e9de9f8e0ebb8cafcdb9a6673e";
    };
    bonk = {
      url = "github:tophc7/bonk?rev=646213784713c7df66795103bf004e5a76a3adc8";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    affinity-nix = {
      url = "github:mrshmllow/affinity-nix?rev=9d2534bb14eb13f583011ae9415fc1871d39dc4e";
    };
    disko = {
      url = "github:nix-community/disko?rev=725ea35e410ad83be4931d1bff7e090eacaf3563";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emyl-nix = {
      url = "path:/repos/emyl-nix";
    };
  };

  outputs = {...} @ inputs: let
    # INFO: Extend nixpkgs lib with mix.nix utilities BEFORE entering flake-parts
    # This gives us lib.fs.*, lib.hosts.*, lib.desktop.*, etc.
    lib = (import "${inputs.mix-nix}/lib") inputs.nixpkgs.lib;
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
          shell = inputs.nixpkgs.legacyPackages.x86_64-linux.zsh;
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
