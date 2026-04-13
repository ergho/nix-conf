{
  pkgs ? import <nixpkgs> { },
  nvf,
  ...
}:
rec {
  bizhawk = pkgs.callPackage ./bizhawk { };

  neovim-config =
    (nvf.lib.neovimConfiguration {
      inherit pkgs;
      modules = [ ./neovim.nix ];
    }).neovim;

}
