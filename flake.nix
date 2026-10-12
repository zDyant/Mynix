{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?rev=84dc35d87e387775da82b754fa1d768bb256e801";
    home-manager = {
      url = "github:nix-community/home-manager?rev=c58f54c733a7894d84fa2fdff26cc12088c4b78c";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix?rev=32d97b6b3c3401e5d0e474c82e764f8f9bf35b86";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix?rev=2856c4c6a845b9bec98828ef197abe176e4806bb";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR?rev=f8508ae9d03b238d5929e88a745eafffc8e060cc";
    };
    git-hooks = {
      url = "github:cachix/git-hooks.nix?rev=a0e4241b51206fbcbf52fd322eb5f0cd80f153c4";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    play = {
      url = "github:TophC7/play.nix";
    };
    nixcord = {
      url = "github:kaylorben/nixcord?rev=1ffd9a241a518fab5c2188749a599a8981cd8208";
    };
    betterfox = {
      url = "github:yokoffing/Betterfox?rev=067172a4b0dc90e78e5b8b94d9abfe6430c6a7be";
      flake = false;
    };
    userstyles = {
      url = "github:knoopx/userContent.css?rev=161cffbecd1eb550e0b230041518ff7feec3a363";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts?rev=024633cd702b10285db5cb19b40ad48d2399ba60";
    };
    mix-nix = {
      url = "github:tophc7/mix.nix?rev=081afb79a0e4fa9201c532110764c68781f4a9b6";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hister = {
      url = "github:asciimoo/hister/v0.20.0";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
    bonk = {
      url = "github:tophc7/bonk?rev=646213784713c7df66795103bf004e5a76a3adc8";
      inputs.nixpkgs.follows = "nixpkgs";
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
