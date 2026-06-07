{
  lib,
  inputs,
  config,
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
      userContent = let
        system = pkgs.stdenv.hostPlatform.system;
        # palette = config.lib.stylix.colors.withHashtag;
        palette = with config.lib.stylix.colors.withHashtag; {
          base00 = base00;
          base01 = base01;
          base02 = base02;
          base03 = base03;
          base04 = base04;
          base05 = base05;
          base06 = base06;
          base07 = base07;
          base08 = base08;
          base09 = base09;
          base0A = base0A;
          base0B = base0B;
          base0C = base0C;
          base0D = base0D;
          base0E = base0E;
          base0F = base0F;
        };
        userStyles =
          inputs.userstyles.lib.${system}.mkUserStyles palette;
      in ''
        ${builtins.readFile userStyles}
      '';
    };
  };
}
