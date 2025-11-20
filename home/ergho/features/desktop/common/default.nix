{
  imports = [
    ./wayland-wm
    ./firefox.nix
    ./fonts.nix
    ./discord.nix
    ./gtk.nix
  ];

  xdg.portal.enable = true;
}
