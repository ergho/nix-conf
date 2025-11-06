{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    extraCompatPackages = [
      pkgs.proton-ge-bin
      pkgs.protonup-qt
    ];
  };
}
