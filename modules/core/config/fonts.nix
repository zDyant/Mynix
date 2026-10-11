{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      # Sans(Serif) fonts
      lexend
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      roboto
      (google-fonts.override {
        fonts = [
          "Inter"
          "Laila"
        ];
      })

      # nerdfonts
      maple-mono.NF
      nerd-fonts.fira-code
      nerd-fonts.symbols-only
    ];

    # causes more issues than it solves
    enableDefaultPackages = false;

    # user defined fonts
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = ["Laila" "Noto Serif CJK JP"];
        sansSerif = ["Lexend" "Noto Sans CJK JP"];
        monospace = ["Maple Mono NF"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
