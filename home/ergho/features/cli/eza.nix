{
  programs.eza = {
    enable = true;
    icons = "auto";
    enableBashIntegration = true;
    git = true;
    extraOptions = [
      "--group-directories-first"
      "--no-quotes"
      "--header"
      "--classify"
      "--hyperlink"
    ];
  };

  home.shellAliases = {
    ls = "eza";
    lt = "eza --tree --level=2";
    ll = "eza -lh --no-user --long";
    la = "eza -lah ";
    lag = "eza -lah --git-ignore";
    lg = "eza -lh --git-ignore";
    tree = "eza --tree";
  };
}
