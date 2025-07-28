{
  pkgs,
  lib,
  ...
}:
let
  steam-with-pkgs = pkgs.steam.override {
    extraPkgs =
      pkgs: with pkgs; [
        xorg.libXcursor
        xorg.libXi
        xorg.libXinerama
        xorg.libXScrnSaver
        libpng
        libpulseaudio
        libvorbis
        stdenv.cc.cc.lib
        libkrb5
        keyutils
        gamescope
      ];
  };
  steam-session =
    let
      gamescope = lib.concatStringsSep " " [
        (lib.getExe pkgs.gamescope)
        "--output-width 2560"
        "--output-height 1440"
        "--framerate-limit 144"
        "--prefer-output DP-1"
        "--adaptive-sync"
        "--expose-wayland"
        "--hdr-enabled"
        "--steam"
      ];
      steam = lib.concatStringsSep " " [
        "steam"
        "steam://open/bigpicture"
      ];
    in
    pkgs.writeTextDir "share/wayland-sessions/steam-session.desktop"

      ''
        [Desktop Entry]
        Name=Steam Session
        Exec=${gamescope} -- ${steam}
        Type=Application
      '';
in
{

  home.packages = [
    steam-with-pkgs
    steam-session
    pkgs.gamescope
    pkgs.protontricks
  ];
}
