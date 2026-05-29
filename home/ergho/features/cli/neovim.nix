{ inputs, pkgs, ... }:
{
  home.sessionVariables = {
    EDITOR = "nvim";
    TESTINGTHIS = "works";
  };

  home.packages = [
    inputs.self.packages.${pkgs.stdenv.system}.neovim-config
  ];
}
