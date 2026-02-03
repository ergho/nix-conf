{ pkgs, ... }:
{
  programs = {
    gh = {
      enable = true;
      extensions = with pkgs; [ gh-markdown-preview ];
      gitCredentialHelper.enable = true;
      settings = {
        version = "1";
        git_protocol = "ssh";
        prompt = "enabled";
      };
    };
  };
}
