{inputs, ...}: {
  mix = {
    apiVersion = 2;
    hostSpecExtensions = [./hostSpec.nix];
    secrets = {
      file = ../secrets.nix;
      gitattributes = ../.gitattributes;
    };
    specialArgs.flakePath = "/repos/dots";
    users.zdyant = {
      name = "zdyant";
      uid = 1000;
      shell = inputs.nixpkgs.legacyPackages.x86_64-linux.zsh;
      extraGroups = [
        "adbusers"
        "audio"
        "docker"
        "gamemode"
        "git"
        "i2c"
        "input"
        "libvirtd"
        "networkmanager"
        "video"
        "wheel"
      ];
    };

    hosts.gaia.user = "zdyant";
    hosts.hephaestus = {
      user = "zdyant";
      isServer = true;
      isMinimal = true;
    };
  };
}
