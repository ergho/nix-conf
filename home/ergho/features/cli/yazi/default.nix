{ pkgs, ... }:
let
  gruvbox-material = pkgs.fetchFromGitHub {
    owner = "matt-dong-123";
    repo = "gruvbox-material.yazi";
    rev = "main";
    sha256 = "sha256-mfIdFIe++jRDbTQBcLlpAq91JzmgL2SvqPxkYuCnKdQ=";

  };
  settings = import ./settings.nix;
in
{
  programs.yazi = {
    inherit settings;
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    theme.flavor = {
      dark = "gruvbox-material";
      light = "gruvbox-material";
    };
    flavors = {
      inherit gruvbox-material;
    };

    plugins = {
      full-border = pkgs.yaziPlugins.full-border;
      git = pkgs.yaziPlugins.git;
      smart-enter = pkgs.yaziPlugins.smart-enter;
      githead = pkgs.yaziPlugins.githead;
    };

  };
}
