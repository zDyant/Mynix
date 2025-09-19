{ pkgs, ... }:
{
  home.packages = with pkgs; [
    rustc
    cargo
    meson
    cmake
    gnumake
    gcc
    nodejs
    # Needed for hyprls
    go
    # python3

    # Required by nvim
    sqlite.dev
    sqlite
    lazygit
    rustfmt # mason can't install, or install using rustup
    # Installed using mason with opts = { PATH = "append" }
    # nixfmt-rfc-style
    # rust-analyzer
    # stylua
    # hyprls
    # lua-language-server
    # astro-language-server
  ];
}
