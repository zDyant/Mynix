{pkgs, ...}: {
  home.packages = with pkgs; [
    protonup-qt
    optiscaler-client
  ];
}
