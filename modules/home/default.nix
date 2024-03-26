{inputs, ... }: {
  imports = 
    [(import ./hyprland)]
++  [(import ./zsh)];
}
