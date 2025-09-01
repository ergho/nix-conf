{ pkgs, outputs, ... }:

{
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    hyprland.enable = true;
    hyprlock.enable = true;
    seahorse.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = builtins.attrValues outputs.overlays;

  environment.systemPackages = with pkgs; [
    cliphist
    cowsay
    duf
    discord
    discord-ptb
    file-roller
    htop
    killall
    libnotify
    lm_sensors
    lshw
    mpv
    nixfmt-rfc-style
    pavucontrol
    pciutils
    ripgrep
    unrar
    unzip
    usbutils
    webcord
    wget
  ];
}
