pkgs: {
  # example = pkgs.callPackage ./example { };
  stremio-enhanced = pkgs.callPackage ./stremio-enhanced.nix { };
  vision-cursor = pkgs.callPackage ./vision-cursor.nix {};
}
