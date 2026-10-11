{pkgs, ...}: {
  boot.loader.grub = {
    device = "/dev/nvme0n1";
    theme = pkgs.nur.repos.zerozawa.grub-theme-yorha;
  };

  boot.plymouth = {
    enable = true;
    themePackages = [(pkgs.catppuccin-plymouth.override {variant = "mocha";})];
    theme = "catppuccin-mocha";
  };
}
