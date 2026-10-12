{flakePath, ...}: {
  programs.bonk = {
    enable = true;
    inherit flakePath;
    buildHost = null; # null = local builds, or "buildserver"
    extraArgs = [];
  };
}
