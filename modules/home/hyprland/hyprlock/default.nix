{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    font-awesome
    maple-mono.NF
    (pkgs.writeShellApplication {
      name = "player";
      runtimeInputs = with pkgs; [
        playerctl
        gawk
        fd
        wget
        bc
      ];
      text = (builtins.readFile ./player.sh);
    })
  ];
  stylix.targets.hyprlock.enable = false;

  programs.hyprlock = let
    border-radius = 0;
    border-thickness = 1;
    mono-font = "MapleMono";
    icon-font = "Font Awesome 6 Free Solid";

    text-color   = "rgb(${config.lib.stylix.colors.base05})";
    bg-color     = "rgb(${config.lib.stylix.colors.base00})";
    accent-color = "rgb(${config.lib.stylix.colors.base0A})";
    fail-color   = "rgb(${config.lib.stylix.colors.base08})";
  in {
    enable = true;
    settings = {
      general = {ignore_empty_input = true;};

      background = [
        {
          path = toString config.stylix.image;
          blur_passes = 0;
        }
      ];

      # Hours
      label = [
        {
          text = ''cmd[update:1000] echo "<b><big> $(date +"%H") </big></b>"'';
          color = accent-color;
          font_size = 156;
          font_family = icon-font;

          position = "0, -10%";
          halign = "center";
          valign = "top";
        }
        # Minutes
        {
          text = ''cmd[update:1000] echo "<b><big> $(date +"%M") </big></b>"'';
          color = accent-color;
          font_size = 156;
          font_family = icon-font;

          position = "0, -28%";
          halign = "center";
          valign = "top";
        }
        # Today
        {
          monitor = "";
          text = ''cmd[update:18000000] echo "<b>Today is "$(date +'%A')" </b>"'';
          color = text-color;
          font_size = 16;
          font_family = mono-font;

          position = "0, 0";
          halign = "center";
          valign = "center";
        }
        # Date
        {
          monitor = "";
          text = ''
            cmd[update:1000] echo "<b>$(bash -c 'day=$(date +%d); case "$day" in 1) suffix="st";; 2) suffix="nd";; 3) suffix="rd";; *) suffix="th";; esac; echo -e "$(date +"%B %e")'$day'$suffix, $(date +%Y)"')</b>"'';
          color = text-color;
          font_size = 18;
          font_family = mono-font;

          position = "0, -32";
          halign = "center";
          valign = "center";
        }
        # Weather
        {
          monitor = "";
          text = ''
            cmd[update:1000] echo "$(curl -s 'wttr.in?format=%l+%c+%C+%t'| tr -d '+' )"'';
          color = text-color;
          font_size = "10%";
          font_family = mono-font;

          position = "0, 1%";
          halign = "center";
          valign = "bottom";
        }
        # Music source
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(player -music --source) "'';
          color = text-color;
          font_size = "1%";
          font_family = icon-font;

          position = "8.5%, 2.5%";
          halign = "left";
          valign = "bottom";
        }
        # Music title
        {
          monitor = "";
          text = ''cmd[update:1000] echo "<b>$(player -music --title)</b>"'';
          color = text-color;
          font_size = "1%";
          font_family = mono-font;

          position = "10%, 2%";
          halign = "left";
          valign = "bottom";
        }
        # Music artist
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(player -music --artist)"'';
          color = text-color;
          font_size = 12;
          font_family = mono-font;

          position = "10%, 0";
          halign = "left";
          valign = "bottom";
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "240, 50";
          outline_thickness = border-thickness;
          rounding = border-radius;

          dots_size = 0.26;
          dots_spacing = 0.64;
          dots_center = true;
          dots_rounding = 0;

          outer_color = accent-color;
          inner_color = bg-color;
          font_color = text-color;
          fail_color = fail-color;

          fade_on_empty = true;
          placeholder_text = "<span>󰢏  $USER </span>";

          position = "0, 120";
          halign = "center";
          valign = "bottom";
        }
      ];

      shape = [
        {
          monitor = "";
          size = "100%, 5%";
          color = bg-color;
          halign = "center";
          valign = "bottom";
          zindex = 0;
        }
      ];

      image = [
        {
          monitor = "";
          path = "~/.config/hypr/hyprlock/music.webp";
          size = "1%";
          rounding = border-radius;
          border_size = border-thickness;
          border_color = accent-color;
          rotate = 0;
          reload_time = 2;
          reload_cmd = "player -music --arturl";

          position = "0, 0";
          halign = "left";
          valign = "bottom";
        }
      ];
    };
  };
}
