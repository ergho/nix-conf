{ pkgs-stable, ... }:

{
  #services.udev.extraRules = ''
  #  ACTION=="add|remove", SUBSYSTEM=="usb", ATTR{idVendor}=="0424", ATTR{idProduct}=="4216", TAG+="systemd", ENV{SYSTEMD_USER_WANTS}="dock-sync.service"
  #'';
  environment.systemPackages = with pkgs-stable; [ citrix_workspace ];
}
