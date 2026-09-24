{ config, ... }:
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
  };
  services.openvpn.servers = {
    worka = {
      config = ''
        config ${config.sops.secrets.openvpn-config.path}
        askpass ${config.sops.secrets.openvpn-password.path}
      '';
      autoStart = false;
      updateResolvConf = false;
    };
  };
}
