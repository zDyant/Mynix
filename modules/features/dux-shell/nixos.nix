{pkgs, ...}: {
  programs.dux-shell.enable = true;
  environment.systemPackages = with pkgs; [
    dsearch
  ];
}
