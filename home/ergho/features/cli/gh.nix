{
  programs = {
    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
      settings = {
        version = "1";
        git_protocol = "ssh";
        prompt = "enabled";
      };
    };
  };
}
