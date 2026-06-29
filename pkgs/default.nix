{
  pkgs ? import <nixpkgs> { },
  nvf,
  ...
}:
rec {
  neovim-config =
    (nvf.lib.neovimConfiguration {
      inherit pkgs;
      modules = [ ./neovim.nix ];
    }).neovim;

}
