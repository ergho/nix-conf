{
  programs.git = {
    enable = true;
    settings = {
      alias = {
        gp = "pull --ff-only";
        ff = "merge --ff-only";
        graph = "log --decorate --oneline --graph";
        co = "checkout";
        com = "commit -a";
        gs = "stash";
        st = "status";
      };

      merge.conflictStyle = "diff3";
      commit.verbose = true;
      log.date = "iso";
      log.decorate = "full";
      column.ui = "auto";
      branch.sort = "comitterdate";
      push.autoSetupRemote = true;
      rerere.enabled = true;
      init.defaultBranch = "main";
      credential.helper = "cache --timeout=7200";
    };
    lfs.enable = true;
    ignores = [
      ".direnv"
      "result"
    ];
  };
}
