{ ... }:
{
  programs.gamemode = {
   enable = true;
   enableRenice = true;
   settings = {

    custom = {
      start = "notify-send -a 'Gamemode' 'Optimizations activated'";
      end = "notify-send -a 'Gamemode' 'Optimizations deactivated'";
    };
   };
  };
}
