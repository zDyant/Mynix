{pkgs, ...}: {
  boot.loader.grub.device = "/dev/nvme0n1";

  emyl.grub = {
    source = pkgs.fetchFromGitHub {
      owner = "Woysful";
      repo = "Marathon-Grub-Themes";
      rev = "a235901b118010947776dd2f4624f074e99ca2a4";
      hash = "sha256-WcPuFoyIESUwSmOa6wK6+3p7O13l+eziHU4jIEIY9Pw=";
    };
    themeFile = "Marathon-NewCascadia/theme_1440p.txt";
  };
}
