{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
      "JetBrainsMono"
      ];
    })
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {

      sansSerif = [ "Geist Sans" ];
      monospace = [ "Geist Mono" "JetBrainsMono Nerd Font" ];
    };
    
  };

}
