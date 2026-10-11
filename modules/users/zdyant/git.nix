{...}: {
  programs.git = {
    enable = true;
    settings = {
      user.name = "zDyant";
      user.email = "dyant@proton.me";
      url = {
        "git@github.com:zdyant/" = {
          insteadOf = "zdyant:";
        };
        "git@github.com" = {
          insteadOf = "gh:";
        };
      };
    };
  };
}
