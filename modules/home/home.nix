{ pkgs, ... }:
{

  home.sessionVariables = {
    EDITOR = "vim";
  }; 

  #nixpkgs =  {
  #  config = {
  #    allowUnfree = true;
  #  };
  #};
  home.packages = with pkgs; [
    eza
    discord-ptb
  ];
}
