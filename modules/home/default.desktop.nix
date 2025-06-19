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
    ./gh.nix
    ./hyprland
    ./waybar
  ];

}
