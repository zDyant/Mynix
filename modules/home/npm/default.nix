{ pkgs, config, lib, ... }: {
  # Add to $PATH
  home.sessionPath = [
    # needed 'cause of npm set prefix ~/.npm-global
    "$HOME/.npm-global/bin"
    "$HOME/.cargo/bin"
  ];

  # github.com/britter/nix-configuration/blob/abdf6168b2a435da6f8d8f14c2fe7893f390cb2d/home/benedikt.nix#L85
  # Run npm config set during activation to store prefix in ~/.npmrc
  home.activation.setNpmPrefix = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.nodejs}/bin/npm config set prefix "${config.home.homeDirectory}/.npm-global"
  '';
}
