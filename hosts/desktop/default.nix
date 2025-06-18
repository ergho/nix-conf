{
  inputs,
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./disko-config.nix
    ./../../modules/core
  ];

  environment.systemPackages = with pkgs; [
    git
    home-manager
    kitty
    neovim
    wofi
    waybar
  ];
}
