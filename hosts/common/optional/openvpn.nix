{ config, pkgs, ... }:
{
  sops.secrets = {

    openvpn-config = {
      sopsFile = ../secrets.yaml;
      owner = "root";
    };
    openvpn-password = {
      sopsFile = ../secrets.yaml;
      owner = "root";
    };
    openvpn-dns-server = {
      sopsFile = ../secrets.yaml;
      owner = "root";
    };
    openvpn-dns-domain = {
      sopsFile = ../secrets.yaml;
      owner = "root";
    };
  };
  services.resolved.enable = true;
  services.openvpn.servers =
    let
      vpnUpScript = pkgs.writeShellScript "vpn-up" ''
        INTERFACE="$1"
        DNS_SERVER=$(/run/current-system/sw/bin/cat ${config.sops.secrets.openvpn-dns-server.path})
        DNS_DOMAIN=$(/run/current-system/sw/bin/cat ${config.sops.secrets.openvpn-dns-domain.path})

        ${pkgs.systemd}/bin/resolvectl dns "$INTERFACE" "$DNS_SERVER"
        ${pkgs.systemd}/bin/resolvectl domain "$INTERFACE" "$DNS_DOMAIN"
      '';
      vpnDownScript = pkgs.writeShellScript "vpn-down" ''
        INTERFACE="$1"
        ${pkgs.systemd}/bin/resolvectl revert "$INTERFACE"
      '';
    in
    {
      worka = {
        config = ''
          config ${config.sops.secrets.openvpn-config.path}
          askpass ${config.sops.secrets.openvpn-password.path}

          script-security 2
          up "${vpnUpScript}"
          down "${vpnDownScript}"
        '';
        autoStart = false;
      };
    };
}
