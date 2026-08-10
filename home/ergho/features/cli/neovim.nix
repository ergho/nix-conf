{ inputs, pkgs, ... }:
{
  home.sessionVariables = {
    EDITOR = "nvim";
    TESTINGTHIS = "works";
  };

  home.packages = [
    inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.neovim-config
  ];
}
