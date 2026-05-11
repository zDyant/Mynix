{
  lib,
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [inputs.mix-nix.homeManagerModules.nautilus];
  programs.nautilus = lib.mkDefault {
    enable = true;

    bookmarks = [
      {path = "${config.home.homeDirectory}/Documents";}
      {path = "${config.home.homeDirectory}/Downloads";}
      {path = "${config.home.homeDirectory}/Pictures";}
      {path = "${config.home.homeDirectory}/Games";}
      {
        path = "/repos/dots";
        name = "Dotfiles";
      }
      {path = "${config.home.homeDirectory}/obsidian";}
    ];

    folderIcons = {
      "/repos/dots" = "folder-linux";
      "${config.home.homeDirectory}/Games/" = "folder-games";
      "${config.home.homeDirectory}/Downloads" = "folder-download";
    };
  };

  # https://github.com/TophC7/arroz.nix/blob/2ce5044dc85b5069e9d2583ced15893da2053c0d/modules/nixos/_shared/nautilus.nix
  home.packages = with pkgs; [
    code-nautilus
    file-roller
    gnome-epub-thumbnailer
    nautilus
    nautilus-python
    # papers
    # sushi
    # turtle
  ];
}
