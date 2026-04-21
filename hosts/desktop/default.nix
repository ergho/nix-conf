{
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix

    ./disko-config.nix

    ../common/global
    ../common/users/ergho
    # Optional components will be added here like example
    # ../common/optional/...
    ../common/optional/nfs.nix
    ../common/optional/regreet.nix
    ../common/optional/pipewire.nix
    ../common/optional/steam.nix
    ../common/optional/tailscale.nix
    ../common/optional/usbaudio.nix
    ../common/optional/work.nix
  ];
  #boot.kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  networking = {
    hostName = "desktop";
  };

  environment.systemPackages = with pkgs; [
    kitty
    neovim
    wofi
    waybar
  ];

  fileSystems."/mnt/media" = {
    device = "truenas.ergho.org:/mnt/BeepyBoopy/Media";
    fsType = "nfs";

    options = [
      "_netdev"
      "noauto"
      "x-systemd.automount"
      "x-systemd.idle_timeout=5s"
      "x-systemd.idle_action=umount-force"
      "soft"
    ];
  };
  hardware.graphics.enable = true;

  system.stateVersion = "25.05";
}
