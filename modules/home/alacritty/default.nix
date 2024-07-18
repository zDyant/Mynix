{ ... }:
{
  programs.alacritty = {
    enable = true;

    settings = {

      import = ["colors.toml"];

      window = {
        decorations = "None";
        opacity = 0.9;
      };

      font = {
          size = 12;
      };

    };
  };
}
