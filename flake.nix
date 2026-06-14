{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?rev=64c08a7ca051951c8eae34e3e3cb1e202fe36786";
    home-manager = {
      url = "github:nix-community/home-manager?rev=7d8127d308c3fb9664f7e643eec944be74ebb37d";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix?rev=c679f3fa9fbe86903486a8f7ad71f99e26481d71";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix?rev=8ed48a41087feeb66372ff718021a9512fc552b3";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR?rev=39917b7f68263188707925ffe26c9df6ef4e7d64";
    };
    git-hooks = {
      url = "github:cachix/git-hooks.nix?rev=61ab0e80d9c7ab14c256b5b453d8b3fb0189ba0a";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    play = {
      url = "github:tophc7/play.nix?rev=fec1003647b457a82a166f7251cd2b1aba1a8f84";
    };
    nixcord = {
      url = "github:kaylorben/nixcord?rev=d0a08d06b3a00b1038b1780366180068af7c1489";
    };
    betterfox = {
      url = "github:yokoffing/Betterfox?rev=c97bc0639609f35ff9d65522e3ddb03dac69e938";
      flake = false;
    };
    userstyles = {
      url = "github:knoopx/userContent.css?rev=f5653b1305a31add191efface54bd9d8cede0c91";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts?rev=f7c1a2d347e4c52d5fb8d10cb4d94b5884e546fb";
    };
    mix-nix = {
      url = "github:tophc7/mix.nix?rev=8039666eed90a4ce06096355ddc30d702d921fa3";
    };
    bonk = {
      url = "github:tophc7/bonk?rev=737bf81523ffd311fbd308938463679a793d1e22";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    affinity-nix = {
      url = "github:mrshmllow/affinity-nix?rev=84994addd36ea35740d2cf2f9de58ed73319aad4";
    };
    disko = {
      url = "github:nix-community/disko?rev=caa775cf67bfdc47f940edd96c975b5016df9059";
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

        # INFO:
        # Run the hooks in a sandbox with `nix flake check`.
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
