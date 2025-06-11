{ inputs, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    #withUWSM = true;
  };
  services.displayManager.gdm.enable = true;
  #services.desktopManager.gnome.enable = true;
}
