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
    # old version, will replace slowly
    ./../../modules/core
  ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  networking = {
    hostName = "desktop";
    useDHCP = true;
  };

  environment.systemPackages = with pkgs; [
    git
    home-manager
    kitty
    neovim
    wofi
    waybar
  ];
  hardware.graphics.enable = true;

  system.stateVersion = "25.04";
}
