{
  lib,
  inputs,
  ...
}:
{
  lix = final: prev: {
    inherit
      (prev.lixPackageSets.stable)
      nixpkgs-review
      nix-direnv
      nix-eval-jobs
      nix-fast-build
      colmena
      ;
  };

  packages = final: _prev:
    import ../pkgs {
      inherit lib;
      pkgs = final;
    };

  unstable-pkgs = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
