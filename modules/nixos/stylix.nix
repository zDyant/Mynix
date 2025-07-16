{ pkgs, ... }:
{
  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";
    targets = {
      grub.enable = false;
    };
    opacity.terminal = 0.8;

    image = pkgs.fetchurl {
      url = "https://www.pixelstalk.net/wp-content/uploads/2016/05/Epic-Anime-Awesome-Wallpapers.jpg";
      sha256 = "enQo3wqhgf0FEPHj2coOCvo7DuZv+x5rL/WIo4qPI50=";
    };
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";

    cursor = {
      package = pkgs.rose-pine-cursor;
      name = "BreezeX-RosePine-Linux";
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
