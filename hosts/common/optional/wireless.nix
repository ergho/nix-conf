{
  config,
  pkgs,
  ...
}:
{
  hardware.bluetooth = {
    enable = true;
  };

  # Wireless secrets stored through sops
  #sops.secrets.wireless = {
  #  sopsFile = ../secrets.yaml;
  #  neededForUsers = true;
  #};

  networking.wireless = {
    enable = true;
    fallbackToWPA2 = false;
    # Declarative
    # secretsFile = config.sops.secrets.wireless.path;
    # networks = {
    # };

    # Imperative
    allowAuxiliaryImperativeNetworks = true;
    # https://discourse.nixos.org/t/is-networking-usercontrolled-working-with-wpa-gui-for-anyone/29659
    extraConfig = ''
      ctrl_interface=DIR=/run/wpa_supplicant GROUP=${config.users.groups.network.name}
      update_config=1
    '';
  };

  # Ensure group exists
  users.groups.network = { };

  systemd.services.wpa_supplicant.preStart = "touch /etc/wpa_supplicant.conf";

  environment = {
    systemPackages = with pkgs; [
      networkd-dispatcher
    ];

    # Dispatcher scripts to disable Wi-Fi when Ethernet is active
    etc."networkd-dispatcher/routable.d/disable-wifi".source = pkgs.writeScript "disable-wifi" ''
      #!${pkgs.bash}/bin/bash
      if [[ "$IFACE" == en*  && "$STATE" == "routeable" ]]; then
        rfkill block wlan || true
      fi
    '';

    etc."networkd-dispatcher/off.d/enable-wifi".source = pkgs.writeScript "enable-wifi" ''
      #!${pkgs.bash}/bin/bash
      if [[ "$IFACE" == en* && "$STATE" == "off" ]]; then
        rfkill unblock wlan || true
      fi
    '';
  };
}
