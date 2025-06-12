{ pkgs, ... }:
{

  programs.bash.enable = true;
  home.sessionVariables = {
    EDITOR = "vim";
    SILLY = "test";
  }; 

  imports = [
    ./eza.nix
    ./hyprland
  ];

  home.packages = with pkgs; [
    discord-ptb
    ripgrep
  ];
}
