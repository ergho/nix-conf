{ ... }:

{
  imports = [
    ../common
    #../common/wayland-wm
    ./hypridle.nix
    ./hyprland.nix
    ./hyprlock.nix
  ];
}
