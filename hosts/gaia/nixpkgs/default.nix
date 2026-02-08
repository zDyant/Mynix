{ inputs, pkgs, ... }: {
  nix = { package = pkgs.lixPackageSets.stable.lix; };

  nixpkgs = {
    overlays = [
      inputs.self.overlays.additions
      inputs.self.overlays.unstable-pkgs
      inputs.self.overlays.modifications
      inputs.self.overlays.lix
    ];
  };

}
