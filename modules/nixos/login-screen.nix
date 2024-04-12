{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects
    (callPackage ./sddm-rose-pine.nix {})
  ];

  
  services.xserver = {
    libinput.enable = true;
    displayManager = {
      defaultSession = "hyprland";
      autoLogin = {
        enable = true;
        user = "zdyant";
      };
      sddm = {
        enable = true;
        theme = "rose-pine";
      };
    };
  };

}
