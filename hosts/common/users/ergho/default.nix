{
  pkgs,
  config,
  lib,
  ...
}:
let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users.users.ergho = {
    isNormalUser = true;
    shell = pkgs.bash;
    extraGroups = ifTheyExist [
      "audio"
      "docker"
      "git"
      "libvirtd"
      "qemu-libvirtd"
      "network"
      "podman"
      "video"
      "wheel"
    ];
    packages = [ pkgs.home-manager ];
    openssh.authorizedKeys.keys = lib.splitString "\n" (
      builtins.readFile ../../../../home/ergho/ssh.pub
    );
    hashedPasswordFile = config.sops.secrets.ergho-password.path;
  };

  sops.secrets.ergho-password = {
    sopsFile = ../../secrets.yaml;
    neededForUsers = true;
  };

  home-manager = {
    users.ergho = import ../../../../home/ergho/${config.networking.hostName}.nix;
    extraSpecialArgs = {
      host = config.networking.hostName;
    };
  };
  security.pam.services = {
    swaylock = { };
    hyprlock = { };
  };
}
