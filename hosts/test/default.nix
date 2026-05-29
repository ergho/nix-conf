{
  inputs,
  pkgs,
  ...
}:

{
  imports = [

    ./hardware-configuration.nix
    ./disko-config.nix
    ../common/global
    ../common/users/ergho
  ];
  #boot.kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  networking = {
    hostName = "test";
  };

  environment.systemPackages = with pkgs; [
    neovim
  ];

  system.stateVersion = "25.05";
}
