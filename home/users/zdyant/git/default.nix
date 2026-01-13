{ ... }: {

  programs.difftastic = {
    enable = true;
    git.enable = true;
  };

  programs.gh = {
    enable = true;
    settings = {
      editor = "nvim";
    };
  };
  programs.gh-dash.enable = true;

  programs.git = {
    enable = true;
    settings = {
      user.name = "zDyant";
      user.email = "dyant@proton.me";
      core = {
        compression = 9;
        whitespace = "error";
        preloadindex = true;
      };
      url = {
        "git@github.com:zdyant/" = { insteadOf = "zdyant:"; };
        "git@github.com" = { insteadOf = "gh:"; };
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
    };
  };
}
