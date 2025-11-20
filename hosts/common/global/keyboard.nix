{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    via
  ];

  services.udev = {
    packages = with pkgs; [
      qmk
      qmk-udev-rules
      qmk_hid
      via
      vial
    ];
    extraRules = ''
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3434", ATTRS{idProduct}=="0e21", GROUP="users", MODE="0600", TAG+="uaccess", TAG+="udev-acl"
    '';
  };
}
