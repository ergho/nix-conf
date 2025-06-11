{ inputs, config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./../../modules/core
    ];


  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };

  services.udev.extraRules = ''
         ACTION=="remove",\
          ENV{ID_BUS}=="usb",\
          ENV{ID_MODEL_ID}=="0407",\
          ENV{ID_VENDOR_ID}=="1050",\
          ENV{ID_VENDOR}=="Yubico",\
          RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"
  '';

  security.rtkit.enable = true;


  # Install firefox.
  programs.firefox.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    home-manager
    hyprlock
    hypridle
    kitty
    vim 
    wofi
    waybar
  ];

}
