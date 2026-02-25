{ pkgs, lib, ... }:

let
  krispPatcher = pkgs.fetchurl {
    url =
      "https://github.com/keysmashes/sys/raw/25f9bc04e6b8d59c1abb32bf4e7ce8ed8de048e2/hm/discord/krisp-patcher.py";
    hash = "sha256-h8Jjd9ZQBjtO3xbnYuxUsDctGEMFUB5hzR/QOQ71j/E=";
  };

  python = pkgs.python3.withPackages (ps: with ps; [ capstone pyelftools ]);

  krispPatcherApp = pkgs.writeShellApplication {
    name = "krisp-patcher-wrapper";

    runtimeInputs = [ pkgs.findutils python ];

    text = ''
      set -euo pipefail

      echo "Searching for discord_krisp.node..."

      nodes="$(${lib.getExe pkgs.findutils}/bin/find \
        "$HOME/.config/discord" \
        -name "discord_krisp.node" \
        -path "*/modules/discord_krisp/*" 2>/dev/null || true)"

      if [ -n "$nodes" ]; then
        while IFS= read -r file; do
          echo "Patching $file"
          ${lib.getExe python} ${krispPatcher} "$file" || true
        done <<< "$nodes"
      else
        echo "No Krisp module found."
      fi
    '';
  };

in {
  systemd.user.services.krisp-patcher = {
    Unit = {
      Description = "Patch Discord Krisp module";
      After = [ "graphical-session.target" ];
    };

    Service = {
      Type = "oneshot";
      ExecStart = lib.getExe krispPatcherApp;
    };

    Install = { WantedBy = [ "default.target" ]; };
  };

  # Re-run automatically when Discord updates
  systemd.user.paths.krisp-patcher = {
    Unit.Description = "Watch Discord for Krisp updates";

    Path.PathModified = [ "%h/.config/discord" ];

    Install.WantedBy = [ "default.target" ];
  };
}
