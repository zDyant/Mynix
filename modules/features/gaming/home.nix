{pkgs, ...}: {
  home.packages = with pkgs; [
    protonup-qt
    nur.repos.uriotv.optiscaler-client
  ];
}
