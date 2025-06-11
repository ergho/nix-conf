{ config, pkgs, ... }:
{
  home.username = "ergho";
  home.homeDirectory = "/home/ergho";
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;

  home.sessionVariables = {
    EDITOR = "vim";
  }; 

  nixpkgs =  {
    config = {
      allowUnfree = true;
    };
  };
  home.packages = with pkgs; [
    eza
    discord-ptb
  ];
}
