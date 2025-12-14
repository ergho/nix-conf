{ config, pkgs, ... }:

{
  imports = [
    ../common
    ./hypridle.nix
    ./hyprland.nix
    ./hyprlock.nix
    #./hyprshot.nix
  ];

  xdg.portal = {
    extraPortals = [
      (pkgs.xdg-desktop-portal-hyprland.override {
        hyprland = config.wayland.windowManager.hyprland.package;
      })
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
    ];

    exportedSessionPackages = [ config.wayland.windowManager.hyprland.package ];
  };
}
