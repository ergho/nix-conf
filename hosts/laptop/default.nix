{
  config,
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-gpu-intel
    inputs.hardware.nixosModules.common-gpu-nvidia
    inputs.hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix

    ../common/global
    ../common/users/ergho

    ../common/optional/greetd.nix
    ../common/optional/pipewire.nix
    ../common/optional/printers.nix
    ../common/optional/wireless.nix
    ../common/optional/work.nix

    #Add in optional components that differ here
    #../common/optional/{item here}
    # Migrating to new layout, leave old until finished
    ../../modules/core

  ];

  # Probably covered by hardware import
  #services.xserver.videoDrivers = [ "nvidia" ];

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
  #boot.kernelPackages = pkgs.linuxPackages_latest;
  networking = {
    hostName = "laptop";
  };
  powerManagement.powertop.enable = true;

  services.logind = {
    lidSwitch = "suspend";
    lidSwitchDocked = "lock";
    lidSwitchExternalPower = "lock";
    powerKey = "suspend";
    powerKeyLongPress = "poweroff";
  };

  hardware = {
    # Webcamera enablement
    ipu6 = {
      enable = true;
      platform = "ipu6epmtl";
    };
    # Might still needed the special settings for the BusIds etc
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;

      nvidiaSettings = true;

      package = config.boot.kernelPackages.nvidiaPackages.stable;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };

        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:0:1:0";
      };
    };
  };

  hardware.graphics.enable = true;

  system.stateVersion = "25.05";
  # everything below here should be migrated elsewhere... :D

  environment.systemPackages = with pkgs; [
    brightnessctl
  ];

}
