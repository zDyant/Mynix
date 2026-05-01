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
    uv
    # python3

    # Required by nvim
    nixd
    lldb
    sqlite.dev
    sqlite
    rustfmt # mason can't install, or install using rustup
    rust-analyzer
    alejandra
    # LSP are installed by mason with opts = { PATH = "append" }
  ];
}
