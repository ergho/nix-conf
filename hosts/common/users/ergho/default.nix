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
  users.mutableUsers = false;
  users.users.ergho = {
    isNormalUser = true;
    shell = pkgs.fish;
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

  sops.secrets = {
    work-a-domain = { };
    work-a-user = { };
    ergho-password = {
      sopsFile = ../../secrets.yaml;
      neededForUsers = true;
    };
  };

  sops.templates."work-a-ssh-config" = {
    path = "${config.users.users.ergho.home}/.ssh/work-a.conf";
    owner = config.users.users.ergho.name;
    group = config.users.users.ergho.group;
    mode = "0600";

    content = ''
      Match host ${config.sops.placeholder."work-a-domain"}
          User ${config.sops.placeholder."work-a-user"}
          PubkeyAuthentication yes
          PKCS11Provider ${pkgs.opensc}/lib/pkcs11/opensc-pkcs11.so
    '';

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
