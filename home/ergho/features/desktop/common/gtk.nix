{ pkgs, ... }:
{
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.apple-cursor;
    name = "macOS";
    size = 24;
  };

  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
