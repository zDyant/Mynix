{ inputs, pkgs, ... }: {
  nix = { package = pkgs.lixPackageSets.stable.lix; };

  nixpkgs = {
    overlays = [
      inputs.self.overlays.unstable-pkgs
      inputs.self.overlays.lix
      inputs.self.overlays.packages
    ];
  };

}
