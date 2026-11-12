{ config, pkgs, ... }:

{
  imports = [
    ../common
    ./hypridle.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./hyprshot.nix
    #    ./hyprpaper.nix
  ];

  xdg.portal = {
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
    ];
    config.hyprland = {
      default = [
        "hyprland"
        "gtk"
      ];
    };
  };

  home = {
    pointerCursor.hyprcursor.enable = true;

    packages = [
      pkgs.grimblast
      pkgs.hyprpicker
      pkgs.kitty
    ];

    exportedSessionPackages = [ config.wayland.windowManager.hyprland.package ];
  };
}
