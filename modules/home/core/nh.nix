{flakeRoot, ...}: {
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 4d --keep 3";
    };
    flake = flakeRoot; # sets NH_OS_FLAKE variable
  };
}
