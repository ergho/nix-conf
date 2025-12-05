{ pkgs, ... }:
{
  imports = [
    ./bash.nix
    ./bat.nix
    ./direnv.nix
    ./eza.nix
    ./git.nix
    ./gh.nix
    ./fish.nix
    ./fzf.nix
    ./neovim.nix
  ];
  home.packages = with pkgs; [
    bc
    bottom
    ncdu
    eza
    ripgrep
    fd
    httpie
    jq
    viddy

    nixd
    alejandra
    nixfmt-rfc-style
    nvd
    nix-diff
    nix-output-monitor
    nh
  ];
}
