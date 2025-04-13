{
  programs.git = {
    enable = true;
    userName = "Hitalo Siqueira";
    userEmail = "hsiqueira10@gmail.com";
    aliases = {
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
    signing = {
      key = null;
      signByDefault = true;
    };
  };
}
