{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?rev=324f531d00b90e4fa5c5263b57c52e8b0a56b4cb";
    home-manager = {
      url = "github:nix-community/home-manager?rev=353742587cbaf079b3caee743115d037bc51fea6";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix?rev=0f478ff79b82abb785160cd4531293f61d21be86";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix?rev=1e6ccadeda179d96728b4a9f20fc9d4dcf6b6059";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR?rev=6a6f82b8fc56faf1eebaaa0475ebe780a5992924";
    };
    git-hooks = {
      url = "github:cachix/git-hooks.nix?rev=43b3c1ab9d40fb1dbb008f451988a91e375825e9";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    play = {
      url = "github:tophc7/play.nix?rev=fec1003647b457a82a166f7251cd2b1aba1a8f84";
    };
    nixcord = {
      url = "github:kaylorben/nixcord?rev=cd8d67d6b4fb646e70725e1dd7dc546bce95da08";
    };
    betterfox = {
      url = "github:yokoffing/Betterfox?rev=8e415d1633f10fe0192d9c938e4ca2628eeec9f9";
      flake = false;
    };
    userstyles = {
      url = "github:knoopx/userContent.css?rev=c2590a73fb89b8cf4b82c991d00a6256333732d2";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts?rev=427bf4bd9435fdf21321c8cc628c24efc14c0f7a";
    };
    mix-nix = {
      url = "github:tophc7/mix.nix?rev=4f851037078544329c6f07661f3742b0a6bf039c";
    };
    bonk = {
      url = "github:tophc7/bonk?rev=646213784713c7df66795103bf004e5a76a3adc8";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    affinity-nix = {
      url = "github:mrshmllow/affinity-nix?rev=a67e334856b7bf0ab9b5b4f38dffd436c0b8a2e5";
    };
    disko = {
      url = "github:nix-community/disko?rev=ff8702b4de27f72b4c78573dfb89ec74e36abdf1";
      inputs.nixpkgs.follows = "nixpkgs";
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
