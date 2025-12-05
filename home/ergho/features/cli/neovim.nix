{ inputs, pkgs, ... }:
{
  home.packages = [
    inputs.self.packages.${pkgs.stdenv.system}.neovim-config
  ];
}
