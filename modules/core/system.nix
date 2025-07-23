{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
  ];
  system.stateVersion = "25.05";
}
