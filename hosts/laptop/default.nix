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

    #Add in optional components that differ here
    #../common/optional/{item here}
    # Migrating to new layout, leave old until finished
    ../../modules/core

  ];

  # Probably covered by hardware import
  #services.xserver.videoDrivers = [ "nvidia" ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  networking.hostName = "laptop";
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

  #security.rtkit.enable = true;

  environment.systemPackages = with pkgs; [
    #intel-media-driver
    #vaapiIntel
    #vaapiVdpau
    #libvdpau-va-gl
    git
    home-manager
    kitty
    vim
    wofi
    waybar
  ];

}
