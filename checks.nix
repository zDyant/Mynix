# https://github.com/EmergentMind/nix-config-starter/blob/a002409272bf775c2ab8ca0f3ab754b859050460/checks.nix
{
  inputs,
  system,
  ...
}: {
  # Use alternative pre-commit implementations
  pre-commit-check = inputs.git-hooks.lib.${system}.run {
    src = ./.;
    default_stages = ["pre-commit"];

    hooks = {
      # ========== General ==========
      check-case-conflicts.enable = true;
      check-shebang-scripts-are-executable.enable = false; # many of the scripts in the config aren't executable because they don't need to be.
      check-merge-conflicts.enable = true;
      detect-private-keys = {
        enable = true;
        excludes = ["^secrets\\.nix$"];
      };
      fix-byte-order-marker.enable = true;
      mixed-line-endings.enable = true;
      trim-trailing-whitespace.enable = true;

      destroyed-symlinks = {
        enable = true;
        name = "destroyed-symlinks";
        description = "detects symlinks which are changed to regular files with a content of a path which that symlink was pointing to.";
        package = inputs.git-hooks.checks.${system}.pre-commit-hooks;
        entry = "${inputs.git-hooks.checks.${system}.pre-commit-hooks}/bin/destroyed-symlinks";
        types = ["symlink"];
      };

      # ========== nix ==========
      alejandra.enable = true;
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
