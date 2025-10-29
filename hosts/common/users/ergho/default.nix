{
  pkgs,
  config,
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
  };
  home-manager.users.ergho = import ../../../../home/ergho/${config.networking.hostName}.nix;
  security.pam.services = {
    swaylock = { };
    hyprlock = { };
  };
}
