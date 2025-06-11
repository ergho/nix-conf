{ pkgs, ... }:
{

  programs.bash.enable = true;
  home.sessionVariables = {
    EDITOR = "vim";
    SILLY = "test";
  }; 

  imports = [
    ./hyprland
  ];

  home.packages = with pkgs; [
    eza
    discord-ptb
    ripgrep
  ];
}
