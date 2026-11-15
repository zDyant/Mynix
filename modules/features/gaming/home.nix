{pkgs, ...}: {
  home.packages = with pkgs; [
    protonplus
    optiscaler-client
  ];
}
