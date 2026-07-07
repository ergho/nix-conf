{ pkgs, ... }:
{
  imports = [
    ./wayland-wm
    ./firefox.nix
    ./fonts.nix
    ./discord.nix
    ./gtk.nix
    ./pavucontrol.nix
    ./pia.nix
  ];

  home.packages = [
    pkgs.libnotify
  ];

  xdg.portal.enable = true;
}
