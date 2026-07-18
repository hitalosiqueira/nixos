{
  programs.git = {
    enable = true;
    settings = {
      user.name = "Hitalo Siqueira";
      user.email = "hsiqueira10@gmail.com";
      alias = {
        br = "branch";
        ci = "commit";
        co = "checkout";
        di = "diff";
        st = "status";
      };
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
        commit.verbose = true;
        pull.rebase = true;
        merge = {
          conflictStyle = "zdiff3";
        };
      };
    };
  };
}
