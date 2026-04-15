{ pkgs, ... }:
{
  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";
    targets = {
      grub.enable = false;
      plymouth.enable = false;
    };

    image = pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/5y/wallhaven-5y7wz1.png";
      sha256 = "sha256-h7MH1ysRaSDlQ8DXHPGmyBmQsdSRKbMQXwVO2N+yVyk=";
    };
    base16Scheme = "${pkgs.base16-schemes}/share/themes/horizon-dark.yaml";

    cursor = {
      package = pkgs.vision-cursor;
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
        name = "Geist";
      };

      monospace = {
        package = pkgs.maple-mono.NF;
        name = "Maple Mono NF";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };

  };
}
