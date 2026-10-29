{
  config,
  ...
}:
#let
#  secretPath = "wpa_supplicant/wireless.secret";
#in
{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };

  # Wireless secrets stored through sops
  sops.secrets.wireless = {
    sopsFile = ../secrets.yaml;
    neededForUsers = true;
    owner = config.users.users.wpa_sppluicant.name;
    group = config.users.users.wpa_sppluicant.group;
  };

  #environment.etc."${secretPath}" = {
  #  enable = true;
  #  user = "wpa_supplicant";
  #  group = "wpa_supplicant";
  #  mode = "0440";
  #  source = config.sops.secrets.wireless.path;
  #};

  networking.wireless = {
    enable = true;
    userControlled = true;
    fallbackToWPA2 = false;
    enableHardening = false;
    # Declarative
    secretsFile = config.sops.secrets.wireless.path;
    networks = {
      "homenet" = {
        pskRaw = "ext:homenet";
      };
      "accelerate" = {
        pskRaw = "ext:accelerate";
      };
      "oneplus 8t" = {
        pskRaw = "ext:oneplus 8t";
      };
    };

    # Imperative
    allowAuxiliaryImperativeNetworks = true;

    extraConfig = "p2p_disabled=1";
  };

  # Ensure group exists
  users.groups.network = { };

  #systemd.services.wpa_supplicant.preStart = "touch /etc/wpa_supplicant.conf";

  services.networkd-dispatcher = {
    enable = true;
    rules = {
      disable-wifi = {

        onState = [
          "routable"
          "configured"
        ];
        script = ''
          #!/bin/bash
          set -euo pipefail

          # Skip Wi-Fi, loopback, VPN, container, and virtual interfaces
          if [[ "$IFACE" =~ ^(wl|lo|veth|br-|virbr|tun|tap|wg|tailscale) ]]; then
            exit 0
          fi

          # disable Wi-Fi if ethernet is routable
          if networkctl list --no-pager --no-legend | grep -q " .*ether .*routable"; then
              echo "Result: Ethernet detected, disabling Wi-Fi."
              networkctl down wlp2s0f0 || true
          fi
        '';
      };
      enable-wifi = {
        onState = [ "off" ];
        script = ''
          #!/bin/bash
          set -euo pipefail

          # Skip Wi-Fi, loopback, VPN, container, and virtual interfaces
          if [[ "$IFACE" =~ ^(wl|lo|veth|br-|virbr|tun|tap|wg|tailscale) ]]; then
            exit 0
          fi

          # enable Wi-Fi if no ethernet interface is routable
          if ! networkctl list --no-pager --no-legend | grep -q " .*ether .*routable "; then
              echo "Result: No routable ethernet detected, enabling Wi-Fi."
              networkctl up wlp2s0f0 || true
          fi
        '';
      };

    };
  };
}
