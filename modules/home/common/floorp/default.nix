{
  lib,
  inputs,
  pkgs,
  host,
  ...
}: let
  user = host.user.name;
in {
  imports = lib.fs.scanPaths ./.;
  home.sessionVariables = {BROWSER = "floorp";};

  stylix.targets.floorp = {
    profileNames = ["${user}"];
    colorTheme.enable = true;
    firefoxGnomeTheme.enable = true;
  };

  programs.floorp = {
    enable = true;
    nativeMessagingHosts = [pkgs.tridactyl-native];

    profiles.${user} = {
      id = 0;
      isDefault = true;
      name = user;
      extraConfig = ''
        ${builtins.readFile "${inputs.betterfox}/user.js"}
        ${builtins.readFile "${inputs.betterfox}/Fastfox.js"}
        ${builtins.readFile "${inputs.betterfox}/Peskyfox.js"}
        ${builtins.readFile "${inputs.betterfox}/Smoothfox.js"}
      '';
    };
  };
}
