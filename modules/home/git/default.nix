{ ... }:
{
  programs.git = {
    enable = true;
    userName = "zDyant";
    userEmail = "dyant@proton.me";
    difftastic = {
      enable = true;
      # display = "inline";
    };
    extraConfig = {
      core = {
        compression = 9;
        whitespace = "error";
        preloadindex = true;
      };
      url = {
        "git@github.com:zdyant/" = {
          insteadOf = "zdyant:";
        };
        "git@github.com" = {
          insteadOf = "gh:";
        };
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
