{pkgs, ...}: {
  programs.difftastic = {
    enable = true;
    git.enable = true;
  };

  programs.git = {
    enable = true;
    package = pkgs.gitFull;

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
      # nix
      "*.drv"
      "result"
      # python
      "*.py?"
      "__pycache__/"
      ".venv/"
      # direnv
      ".direnv"
    ];
  };
}
