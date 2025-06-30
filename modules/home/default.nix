{ pkgs, ... }:
{

  programs.bash.enable = true;

  imports = [
    ./bat.nix
    ./eza.nix
    ./firefox.nix
    ./gh.nix
    ./hyprland
    ./quickemu.nix
    ./tmux.nix
    ./waybar
  ];
}
