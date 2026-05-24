{pkgs, ...}: {
  programs.difftastic = {
    enable = true;
    git.enable = true;
  };

  programs.gh-dash.enable = true;
  programs.lazygit.enable = true;

  programs.gh = {
    enable = true;
    settings = {
      editor = "nvim";
    };
  };

  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    signing.format = "openpgp";

    settings = {
      core = {
        compression = 9;
        whitespace = "error";
        preloadindex = true;
      };

      status = {
        branch = true;
        showStash = true;
      };

      diff = {
        context = 3;
        renames = "copies";
        interHunkContext = 10;
      };

      extraConfig = {
        init.defaultBranch = "main";
        pull = {
          rebase = true;
          ff = "only";
        };
        core.editor = "nvim";
      };
    };

    ignores = [
      ".csvignore"
      "node_modules"

      ".pre-commit-config.yaml"
      ".codex"
      ".bak/"
      "*.bak"

      # nix
      "*.drv"
      "result"
      # python
      "*.py?"
      "__pycache__/"
      ".venv/"
      # direnv
      ".direnv/"
    ];
  };
}
