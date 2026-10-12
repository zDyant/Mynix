# https://github.com/TophC7/dot.nix/blob/dad14d46b32b4a2e2a9b32935ceacd6dcd3d12d6/modules/home/common/xdg.nix
{
  pkgs,
  config,
  ...
}: let
  terminal = "${pkgs.kitty}/bin/kitty";

  files = ["yazi.desktop"];
  browser = ["floorp.desktop"];
  editor = ["nvim.desktop"];
  steam = ["steam.desktop"];
  heroic = ["com.heroicgameslauncher.hgl.desktop"];
  archive = ["org.gnome.FileRoller.desktop"];
  pdfViewer = ["org.pwmt.zathura-pdf-mupdf.desktop"];
  imageViewer = ["imv.desktop"];
  videoPlayer = ["mpv.desktop"];

  associations = {
    "x-scheme-handler/steam" = steam;
    "x-scheme-handler/steamlink" = steam;
    "x-scheme-handler/heroic" = heroic;

    "inode/directory" = files;

    # Text and coding file types
    "text/plain" = editor;
    "text/x-authors" = editor;
    "text/x-changelog" = editor;
    "text/x-copying" = editor;
    "text/x-install" = editor;
    "text/x-license" = editor;
    "text/x-log" = editor;
    "text/x-makefile" = editor;
    "text/x-readme" = editor;

    "application/javascript" = editor;
    "application/json" = editor;
    "application/toml" = editor;
    "application/typescript" = editor;
    "application/x-desktop" = editor;
    "application/x-perl" = editor;
    "application/x-python" = editor;
    "application/x-ruby" = editor;
    "application/x-shellscript" = editor;
    "application/x-wine-extension-ini" = editor;
    "application/x-yaml" = editor;
    "application/xml" = editor;
    "application/yaml" = editor;

    "text/css" = editor;
    "text/html" = editor;
    "text/markdown" = editor;
    "text/x-c++hdr" = editor;
    "text/x-c++src" = editor;
    "text/x-chdr" = editor;
    "text/x-csrc" = editor;
    "text/x-go" = editor;
    "text/x-java" = editor;
    "text/x-markdown" = editor;
    "text/x-nix" = editor;
    "text/x-php" = editor;
    "text/x-ruby" = editor;
    "text/x-rust" = editor;
    "text/x-script.python" = editor;

    "text/x-cmake" = editor;
    "text/x-dockerfile" = editor;
    "application/x-subrip" = editor;
    "application/x-zerosize" = editor;

    # Web content
    "application/x-extension-htm" = browser;
    "application/x-extension-html" = browser;
    "application/x-extension-shtml" = browser;
    "application/x-extension-xht" = browser;
    "application/x-extension-xhtml" = browser;
    "application/xhtml+xml" = browser;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;

    # PDF
    "application/pdf" = pdfViewer;

    # Images
    "image/bmp" = imageViewer;
    "image/gif" = imageViewer;
    "image/jpeg" = imageViewer;
    "image/png" = imageViewer;
    "image/svg+xml" = imageViewer;
    "image/tiff" = imageViewer;
    "image/vnd.microsoft.icon" = imageViewer;
    "image/webp" = imageViewer;
    "image/x-icon" = imageViewer;

    # Video / audio

    "audio/mpeg" = videoPlayer;
    "audio/flac" = videoPlayer;
    "audio/ogg" = videoPlayer;
    "audio/opus" = videoPlayer;
    "audio/x-wav" = videoPlayer;
    "audio/mp4" = videoPlayer;
    "video/mp4" = videoPlayer;
    "video/mpeg" = videoPlayer;
    "video/ogg" = videoPlayer;
    "video/webm" = videoPlayer;
    "video/x-matroska" = videoPlayer;
    "video/x-msvideo" = videoPlayer;

    # Archives
    "application/gzip" = archive;
    "application/vnd.rar" = archive;
    "application/x-7z-compressed" = archive;
    "application/x-ace" = archive;
    "application/x-archive" = archive;
    "application/x-arj" = archive;
    "application/x-bzip-compressed-tar" = archive;
    "application/x-bzip2" = archive;
    "application/x-compress" = archive;
    "application/x-compressed-tar" = archive;
    "application/x-compressed" = archive;
    "application/x-cpio" = archive;
    "application/x-deb" = archive;
    "application/x-gtar" = archive;
    "application/x-gzip" = archive;
    "application/x-iso9660-image" = archive;
    "application/x-lz4" = archive;
    "application/x-lzip" = archive;
    "application/x-lzma-compressed-tar" = archive;
    "application/x-lzma" = archive;
    "application/x-rar-compressed" = archive;
    "application/x-rar" = archive;
    "application/x-rpm" = archive;
    "application/x-tar" = archive;
    "application/x-xz-compressed-tar" = archive;
    "application/x-xz" = archive;
    "application/x-zip-compressed" = archive;
    "application/x-zstd-compressed-tar" = archive;
    "application/zip" = archive;
    "application/zstd" = archive;
  };
in {
  targets.genericLinux.enable = true;

  xdg.desktopEntries = {
    yazi = {
      name = "Yazi";
      genericName = "File Manager";
      comment = "Terminal file manager";
      exec = "${terminal} --class yazi -e ${pkgs.yazi}/bin/yazi %U";
      terminal = false;
      icon = "yazi";
      categories = ["System" "FileTools" "FileManager" "ConsoleOnly"];
      mimeType = ["inode/directory"];
    };
    nvim = {
      name = "Neovim";
      genericName = "Text Editor";
      comment = "Edit text files";
      exec = "${terminal} --class nvim -e ${pkgs.neovim}/bin/nvim %F";
      terminal = false;
      icon = "nvim";
      categories = ["Utility" "TextEditor" "ConsoleOnly"];
      mimeType = ["text/plain"];
    };
  };

  xdg = {
    mime.enable = true;
    mimeApps.enable = true;
    mimeApps.defaultApplications = associations;
    mimeApps.associations.added = associations;
    systemDirs.data = [
      "${config.home.profileDirectory}/share"
      "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
      "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
    ];
  };

  home.packages = builtins.attrValues {
    inherit (pkgs) handlr-regex file-roller;
  };
}
