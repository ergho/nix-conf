{ pkgs, ... }:
{

  programs.bash.enable = true;
  home.sessionVariables = {
    EDITOR = "vim";
    SILLY = "test";
  };

  imports = [
    ./eza.nix
    ./gh.nix
    ./hyprland
  ];

}
