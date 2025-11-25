# Shell for bootstrapping flake-enabled nix and other tooling
{
  pkgs ?
    # If pkgs is not defined, instantiate nixpkgs from locked commit
    let
      lock = (builtins.fromJSON (builtins.readFile ./flake.lock)).nodes.nixpkgs.locked;
      nixpkgs = fetchTarball {
        url = "https://github.com/nixos/nixpkgs/archive/${lock.rev}.tar.gz";
        sha256 = lock.narHash;
      };
    in
    import nixpkgs { overlays = [ ]; },
  checks,
  ...
}:

{
  default = pkgs.mkShell {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes";
    inherit (checks.pre-commit-check) shellHook;
    buildInputs = checks.pre-commit-check.enabledPackages;

    nativeBuildInputs = with pkgs; [

      # NOTE(starter): add any packages you want available in the shell when accessing the parent directory.
      # These will be installed regardless of what was installed specific for the host or home configs
      nix
      home-manager
      nh
      git
      just
      pre-commit
      deadnix
      sops
    ];
  };
}
