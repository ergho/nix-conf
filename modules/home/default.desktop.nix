{ pkgs, ... }:
{

  programs.bash.enable = true;
  home.sessionVariables = {
    EDITOR = "vim";
    SILLY = "test";
  };

  imports = [
    ./bat.nix
    ./eza.nix
    ./firefox.nix
    ./gh.nix
    ./hyprland
    ./waybar
  ];

}
