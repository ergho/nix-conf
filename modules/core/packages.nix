{ pkgs, ... }:

{
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    firefox.enable = true;
    hyprland.enable = true;
    hyprlock.enable = true;
    seahorse.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    brightnessctl
    cliphist
    cowsay
    duf
    discord-ptb
    eza
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
    wget
  ];
}
