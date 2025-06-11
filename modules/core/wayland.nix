{ inputs, pkgs, ... }:

{
  programs.hyprland.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
}
