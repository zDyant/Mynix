{ pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      geist-font
      maple-mono.variable
      nerd-fonts.jetbrains-mono
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [  "Geist"  ];
        sansSerif = [ "Geist Sans" ];
        monospace = [ "Maple Mono" "Geist Mono" ];
      };
      
    };

  };
}
