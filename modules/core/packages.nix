{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    cliphist
    cowsay
    duf
    file-roller
    htop
    killall
    lm_sensors
    lshw
    mpv
    nixfmt-rfc-style
    pciutils
    unrar
    unzip
    usbutils
    wget
  ];
}
