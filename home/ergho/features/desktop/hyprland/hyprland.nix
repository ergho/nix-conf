{ pkgs, ... }:

{
  home.packages = with pkgs; [
    hyprpolkitagent
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    systemd.enable = true;
    extraLuaFiles = {
      settings = ./settings.lua;
    };
  };
}
