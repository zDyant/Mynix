# https://github.com/EmergentMind/nix-config-starter/blob/a002409272bf775c2ab8ca0f3ab754b859050460/checks.nix
{ inputs, system, ... }:
{
  # Use alternative pre-commit implementations

  pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
    src = ./.;
    default_stages = [ "pre-commit" ];

    hooks = {
      # ========== General ==========
      check-case-conflicts.enable = true;
      check-executables-have-shebangs.enable = true;
      check-shebang-scripts-are-executable.enable = false; # many of the scripts in the config aren't executable because they don't need to be.
      check-merge-conflicts.enable = true;
      detect-private-keys.enable = true;
      fix-byte-order-marker.enable = true;
      mixed-line-endings.enable = true;
      trim-trailing-whitespace.enable = true;

      # ========== nix ==========
      # nixfmt-rfc-style.enable = true;
      deadnix = {
        enable = true;
        settings = {
          noLambdaArg = true;
          edit = true;
        };
      };

      # ========== shellscripts ==========
      shfmt.enable = true;
      shellcheck.enable = true;

      end-of-file-fixer.enable = true;
    };
  };
}
