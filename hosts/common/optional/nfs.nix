{ pkgs, ... }:
{
  services.rpcbind.enable = true;
  boot.kernelModules = [
    "nfs"
    "nfs4"
  ];

  environment.systemPackages = with pkgs; [
    nfs-utils
  ];

}
