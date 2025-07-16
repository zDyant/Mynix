{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    # Quickshell stuff
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5.qtpositioning
    libsForQt5.qt5.qtgraphicaleffects
    kdePackages.qtbase
    kdePackages.qtdeclarative
    kdePackages.qtstyleplugin-kvantum
    kdePackages.qtpositioning
    qt6Packages.qt5compat
    power-profiles-daemon
    brightnessctl
    kdePackages.syntax-highlighting
    material-symbols
    upower
    matugen
    python313Packages.kde-material-you-colors
    python3Full
    (inputs.quickshell.packages.${pkgs.system}.default.override {
      withJemalloc = true;
      withQtSvg = true;
      withWayland = true;
      withX11 = false;
      withPipewire = true;
      withPam = true;
      withHyprland = true;
      withI3 = false;
    })
  ];
}
