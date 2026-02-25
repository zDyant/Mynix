pkgs: {
  # example = pkgs.callPackage ./example { };
  stremio-enhanced = pkgs.callPackage ./stremio-enhanced.nix { };
  vision-cursor = pkgs.callPackage ./vision-cursor.nix { };
  hints = pkgs.callPackage ./hints.nix { python3Packages = pkgs.python312Packages; };
  pixora-icon-theme = pkgs.callPackage ./pixora.nix { };
}
