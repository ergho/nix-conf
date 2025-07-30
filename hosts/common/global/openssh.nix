{ outputs, lib, ... }:
let
  hosts = lib.attrNames outputs.nixosConfigurations;
in
{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      StreamLocalBindUnlink = "yes";
      GatewayPorts = "clientspecified";
      AcceptEnv = "WAYLAND_DISPLAY";
      X11Forwarding = true;
    };
  };
  programs.ssh = {

    knownHosts = lib.genAttrs hosts (hostname: {
      publicKeyFile = ../../${hostname}/ssh_host_ed25519_key.pub;
    });
  };
}
