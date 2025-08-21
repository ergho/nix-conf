{ pkgs, ... }:

{
  #  services.udev.extraRules = ''
  #    ACTION=="add|remove", SUBSYSTEM=="usb", ATTR{idVendor}=="0424", ATTR{idProduct}=="4216", TAG+="systemd", ENV{SYSTEMD_USER_WANTS}="dock-sync.service"
  #  '';

  systemd.user.services."dock-sync" = {
    Unit = {
      Description = "Sync display setup with dock state";
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "dock-sync" ''
        if ${pkgs.usbutils}/bin/lsusb | grep -q "0424:4216"; then
          ${pkgs.hyprland}/bin/hyprctl keyword monitor "eDP-1, disable"
        else
          ${pkgs.hyprland}/bin/hyprctl keyword monitor "eDP-1, preferred, auto, 1"
        fi
      '';
    };
    Install.WantedBy = [ "default.target" ];
  };
}
