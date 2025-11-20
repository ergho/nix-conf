{ config, pkgs, ... }:

{
  imports = [
    ../common
    ./hypridle.nix
    ./hyprland.nix
    ./hyprlock.nix
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
}
