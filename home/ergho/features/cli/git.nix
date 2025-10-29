{
  programs.git = {
    enable = true;
    settings = {
      aliases = {
        p = "pull --ff-only";
        ff = "merge --ff-only";
        graph = "log --decorate --oneline --graph";
      };

      extraConfig = {
        merge.conflictStyle = "zdiff3";
        commit.verbose = true;
        log.date = "iso";
        column.ui = "auto";
        branch.sort = "comitterdate";
        push.autoSetupRemote = true;
        rerere.enabled = true;
      };
    };
    lfs.enable = true;
    ignores = [
      ".direnv"
      "result"
    ];
  };
}
