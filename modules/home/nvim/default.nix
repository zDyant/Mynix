{ pkgs, ... }:
{
  home.packages = with pkgs; [
    unstable.lunarvim
    rustc
    cargo
    meson
    cmake
    gnumake
    gcc
    # python3

    # Required by nvim
    sqlite.dev
    sqlite
    rust-analyzer
    stylua
    lua-language-server
    astro-language-server
    lazygit
    nixfmt-rfc-style
  ];

  # xdg.configFile."lvim" = {
  #   source = config.lib.file.mkOutOfStoreSymlink ./lvim;
  #   recursive = true;
  # };

}
