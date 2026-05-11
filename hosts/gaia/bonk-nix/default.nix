{ ... }: {
  programs.bonk = {
    enable = true;
    flakePath = "/repos/dots"; # Your flake location
    buildHost = null; # null = local builds, or "buildserver"
    extraArgs = [ "" ]; # Extra args passed to nh/nix
  };
}
