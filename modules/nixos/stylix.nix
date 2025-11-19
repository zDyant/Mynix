{ pkgs, ... }:
{
  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";
    targets = {
      grub.enable = false;
    };

    image = pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/o5/wallhaven-o5zrj7.jpg";
      sha256 = "sha256-oL0wnPOdNQbryau0F6ie715gbd/W41vzCOfuBJeCkVA=";
    };
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";

    cursor = {
      package = ( pkgs.callPackage ./vision-cursor.nix {} );
      name = "Vision-White";
      size = 28;
    };

    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sansSerif = {
        package = pkgs.geist-font;
        name = "Geist Sans";
      };

      monospace = {
        package = pkgs.maple-mono.variable;
        name = "Maple Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };

  };
}
