{
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    ./disko-config.nix
    ./hardware-configuration.nix
  ];
  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  services.openssh.enable = true;
  networking = {
    hostName = "test";
  };

  environment.systemPackages = with pkgs; [
    neovim
  ];
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIjAbBqkkHSiJ8lW47D3LXPjhXLhH72EtqDtdub8inPt"
  ];

  system.stateVersion = "25.05";
}
