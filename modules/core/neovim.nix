{ inputs, pkgs, ... }:
{
  environment.systemPackages = [ inputs.self.packages.${pkgs.stdenv.system}.neovim-config ];
}
