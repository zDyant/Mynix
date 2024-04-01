{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    theme = "Rosé Pine";
    font = {
    name = "JetBrainsMono Nerd Font";
    size = 11;
    };
    settings = {
    mouse_hide_wait = 0;
    confirm_os_window_close = 0;
    };

  };
}
